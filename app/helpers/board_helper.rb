module BoardHelper

  def forum_page?
    params[:controller] == 'forem/forums' && params[:action] == 'show' 
  end

end
