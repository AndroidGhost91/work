Forem.user_class = "User"
Forem.email_from_address = "info@czardom.com"
Forem.avatar_user_method = :image_url
Forem.per_page = 20
Forem.formatter = Services::HtmlSanitizer

Rails.application.config.to_prepare do
  Forem::ApplicationController.layout "boards"
  Forem::ApplicationController.before_action :authenticate_user!
end

# Rails.application.config.to_prepare do
#   If you want to change the layout that Forem uses, uncomment and customize the next line:
#   Forem::ApplicationController.layout "forem"
#
#   If you want to add your own cancan Abilities to Forem, uncomment and customize the next line:
#   Forem::Ability.register_ability(Ability)
# end
#
# By default, these lines will use the layout located at app/views/layouts/forem.html.erb in your application.
