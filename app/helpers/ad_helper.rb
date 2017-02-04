module AdHelper

  def main_page?
    ad_page_type == :main
  end

  def event_page?
    ad_page_type == :event
  end
  
  def group_page?
    params[:controller] =~ /forums/i && params[:action] == 'show'
  end

  private 

  def ad_page_type
    (params[:controller] =~ /event/i) ? :event : :main
  end

end
