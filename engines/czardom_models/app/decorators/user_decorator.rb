class UserDecorator < Draper::Decorator
  delegate_all

  def company_name
    profile_item('company', 'briefcase', object.company_name)
  end

  def title
    profile_item('title', 'info-circle', object.title)
  end

  def website_link
    return unless website.present?
    profile_item('website', 'globe', h.link_to_website(website))
  end

  def location
    if address.present?
      profile_item('current city', 'map-marker', "#{address.city}, #{address.state}")
    else
      profile_item('current city', 'map-marker', h.link_to('Add Location', h.edit_user_path(object)))
    end
  end

  def work
    profile_item('workplace', 'building', object.work)
  end

  def education
    profile_item('education', 'graduation-cap', object.education)
  end

  def phone
    profile_item('phone', 'phone', phone_number)
  end

  def resume
    return if object.resume.blank?
    profile_item('resume', 'file-text', h.link_to('download resume', resume_url))
  end

  def facebook_link
    return if access_token.blank?
    social_icon('facebook', facebook_me['link'], 'Facebook')
  rescue Koala::Facebook::AuthenticationError => e
  end

  # def vine_link
  #   return if social_link_vine.blank?
  #   social_icon('vine', h.add_protocol("vine.co/#{social_link_vine}"), 'Vine')
  # end

  def twitter_link
    return if twitter_username.blank?
    social_icon('twitter', h.add_protocol("twitter.com/#{twitter_username}"), 'Twitter')
  end

  def instagram_link
    return if social_link_instagram.blank?
    social_icon('instagram', h.add_protocol("instagram.com/#{social_link_instagram}"), 'Instagram')
  end

  def linked_in_link
    return if linked_in.blank?
    social_icon('linkedin', h.add_protocol(linked_in), 'LinkedIn')
  end

  def google_plus_link
    return if google_plus_id.blank?
    social_icon('google-plus', "https://plus.google.com/u/0/#{google_plus_id}/posts", 'Google+')
  end

  def pinterest_link
    return if pinterest_username.blank?
    social_icon('pinterest-p', h.add_protocol("www.pinterest.com/#{pinterest_username}"), 'Pinterest')
  end

  def youtube_link
    return if social_link_youtube.blank?
    social_icon('youtube-play', h.add_protocol(social_link_youtube), 'YouTube')
  end

  def tumblr_link
    return if social_link_tumblr.blank?
    social_icon('tumblr', h.add_protocol(social_link_tumblr), 'Tumblr')
  end

  def snapchat_link
    return if social_link_snapchat.blank?
    h.content_tag(:span, h.icon('snapchat'), class: 'social snapchat', title: social_link_snapchat, 'data-toggle' => 'tooltip')
  end

  def whatsapp_link
    return if social_link_whatsapp.blank?
    h.content_tag(:span, h.icon('whatsapp'), class: 'social whatsapp', title: social_link_whatsapp, 'data-toggle' => 'tooltip')
  end

  private

  def profile_item(title, icon, text)
    unless text.blank?
      h.content_tag(:span, class: "overview-item user-#{title.parameterize}", title: title, data: { toggle: 'tooltip' }) do
        h.icon(icon) + " #{text}".html_safe
      end
    end
  end

  def social_icon(icon, url, title)
    h.link_to h.icon(icon), h.add_protocol(url), target: '_blank', class: "social #{File.basename(icon)}", title: title, data: { toggle: 'tooltip' }
  end

end
