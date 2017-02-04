module UserRoles
  extend ActiveSupport::Concern

  included do

    roles_attribute :roles_mask

    # declare the valid roles -- do not change the order if you add more
    # roles later, always append them at the end!
    roles \
      :users, :edit_user, :user_account_status,
      :groups, :edit_group, :delete_group,
      :tips, :edit_tip, :delete_tip,
      :special_offers, :edit_special_offer, :delete_special_offer,
      :messages,
      :products, :edit_product,
      :regions, :edit_region,
      :sales, :individual_sale,
      :basic_dashboard_reports,
      :slides, :edit_slide, :delete_slide,
      :subscription_plans, :create_subscription_plan,
      :delete_region
  end

end
