module HtmlSafeHelper
  def textilize_with_html_safe(text)
    textilize_without_html_safe(text).html_safe
  end
  alias_method_chain :textilize, :html_safe
end