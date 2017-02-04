class AddCompanyNameAndTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :title, :string
  end
end
