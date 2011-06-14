class PicoMoney < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :account

  def identity
    api_request({}) do
      access_token.get '/about_user'
    end
  end
  memoize :identity

  private

  def access_token
    OAuth::AccessToken.new(self.class.client, self.token, self.secret)
  end

  def api_request(if_failed = nil)
    response = yield
    JSON.parse(response.body).with_indifferent_access
  rescue => e
    case e
    when OAuth::Unauthorized
      destroy
    else
      # something others?
    end
    if_failed
  end

  class << self
    def config
      @config ||= YAML.load_file("#{Rails.root}/config/pico_money.yml")[Rails.env].symbolize_keys
    rescue Errno::ENOENT => e
      raise StandardError.new("config/pico_money.yml could not be loaded.")
    end

    def client
      client = OAuth::Consumer.new(
        config[:client_id],
        config[:client_secret],
        site: 'https://picomoney.com'
      )
    end

    def request_token!(callback)
      client.get_request_token(oauth_callback: callback)
    end

    def access_token!(token, secret, code)
      OAuth::RequestToken.new(client, token, secret).get_access_token(oauth_verifier: code)
    end

    def authenticate!(token, secret, code)
      access_token = access_token!(token, secret, code)
      identity = new(
        token:  access_token.token,
        secret: access_token.secret
      ).identity
      pico = find_or_initialize_by_identifier(identity[:login])
      pico.update_attributes!(
        token:     access_token.token,
        secret:    access_token.secret,
        profile:   identity[:profile],
        thumbnail: identity[:thumbnail_url]
      )
      pico.account || Account.create!(pico_money: pico)
    end
  end

end
