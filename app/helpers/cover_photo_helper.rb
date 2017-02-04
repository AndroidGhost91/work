module CoverPhotoHelper

  def cover_photo(photo_url)
    @cover_photo_url = photo_url
  end

  def display_cover_photo
    options = { class: 'profile-cover-photo' }
    if @cover_photo_url.present?
      options[:style] = "background-image: url(#{@cover_photo_url})"
    else
      options[:style] = "background-color: #E3D5C9; background-image: url(#{image_url 'home-cover.jpg'}); background-position: right -90px; background-size: 700px;"
    end

    return if @cover_photo_url == false

    content_tag(:div, '', options)
  end

end
