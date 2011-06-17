module MetaDataHelper
  def meta_tag(name, options = {})
    tag :meta, options.merge(name: name)
  end

  def link_tag(rel, options = {})
    tag :link, options.merge(rel: rel)
  end
end