class AddUseUrlToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :use_url, :integer, default: 0
  end
end
