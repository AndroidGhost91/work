module UsersHelper

  def avatar_tag(user, options = {})
    option = {}
    option[:alt] = user.try(:full_name)
    classes = options.fetch(:class, '')
    option[:class] = "#{classes} user-avatar"
    
    # if(options.fetch(:size, {}) == ":tiny")
    #   actual_size = "48 * 48"
    # else 
    #   actual_size = "60 * 60"
    # end 
    
    #image_tag user.image_url,option, size: "#{actual_size}" 
    image_tag user.image_url(options.fetch(:size, {})), options
  end

  def edit_id(user)
    return if user == current_user
    user
  end

  def geneate_crown(user)
    if user.recommendations_count >= 30
      image_tag "3.png", alt: "Golden crown", size: "35"
    elsif user.recommendations_count >= 10
      image_tag "2.png", alt: "Silver crown", size: "30"
    elsif user.recommendations_count >= 1
      image_tag "1.png", alt: "Iron crown", size: "25"
    else
      ""
    end
  end

  def format_number_follower(user)
    follower_total = user.followers.count
    follower_total > 500 ? "500+" : follower_total
  end

end
