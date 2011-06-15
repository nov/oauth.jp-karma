module ApplicationHelper
  include Authentication::Helper

  def textilize(text)
    RedCloth.new(text).to_html.html_safe
  end
end
