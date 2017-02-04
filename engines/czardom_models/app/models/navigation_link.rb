class NavigationLink < ActiveRecord::Base
  default_scope lambda { order(:position) }
end
