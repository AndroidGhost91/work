module UrlHelper

  def link_to_website(website)
    return '' if website.blank?
    link_to remove_protocol(website), add_protocol(website), target: '_blank'
  end

  def remove_protocol(url)
    url.gsub(/^https?:\/\//, '')
  end

  def add_protocol(url)
    return '' if url.blank?
    return url if /^http/.match(url)
    url = remove_protocol(url)
    "http://#{url}"
  end

end
