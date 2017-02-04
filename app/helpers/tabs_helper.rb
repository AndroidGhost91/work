module TabsHelper
  
  def active_nav_class(name, action = nil, id = nil)
    if action.present?
      return if controller.action_name != action
    end

    if id.present?
      return if params[:id] != id
    end
    
    'active' if controller.controller_name =~ /#{name}/i
  end
  
end

