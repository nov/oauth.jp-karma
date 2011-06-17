module MobileHelper
  include MetaDataHelper

  module Apple
    def apple_app_capable_meta_tag
      meta_tag :'apple-mobile-web-app-capable'
    end

    def apple_app_icon_link_tag
      link_tag :'apple-touch-icon', href: image_path('logo.png')
    end
  end
  include Apple

  def viewport_meta_tag
    meta_tag :viewport, content: [
      'width=device-width',
      'initial-scale=1',
      'user-scalable=no'
    ].join(',')
  end

end