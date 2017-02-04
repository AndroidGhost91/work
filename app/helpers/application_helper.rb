module ApplicationHelper

  def all_username
    User.pluck(:slug).compact
  end

  # need html_safe then
  def make_link_for_usernames(text)
    text.gsub /(?:^|\W)                   
        @((?>[a-z0-9][a-z0-9-]*))  
        (?!\/)                     
        (?=\.+[ \t\W]|\.+$|[^0-9a-zA-Z_.]|$)/ix do |slug|
      # link_to(slug, main_app.user_path(slug.gsub('@', '')))
      slug = slug.gsub('@', '')
      link_to(slug, "/users/#{slug}")
    end
  end

  def page_title(options = {})
    return unless content_for?(:page_title)
    title = ''

    if options.fetch(:prepend, false)
      title << options[:prepend] + " "
    end

    title << content_for(:page_title)

    if options.fetch(:append, false)
      title << " " + options[:append]
    end

    title
  end

  def title(page_title)
    content_for(:page_title, page_title)
  end

  def preregister_path?
    request.url =~ /preregister/
  end

  def generate_notification_description(notification)
    "#{notification.description} - <i><small>#{time_ago_in_words(notification.created_at) + ' ago'}</small></i>"
  end

  def generate_notification_url(notification)
    "#{notification.url}?ref_notify=#{notification.id}"
  end

  def should_hide_sidebar?
    hidden_paths = ["/map/", "/calendar/", "/complete", "onboarding/groups", "users/new"]
    hidden_paths.each do |key|
      return true if request.path.index(key).present?
    end
    false
  end

end
