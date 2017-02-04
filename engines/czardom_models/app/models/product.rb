class Product < ActiveRecord::Base
  include Payola::Sellable

  has_many :sales, lambda { where('state = ?', 'finished') }, class_name: 'Payola::Sale', as: :product

  def redirect_path(object = nil)
    self.read_attribute(:redirect_path)
  end

  def price_in_dollars
    price / 100.0
  end

  def gross_sales
    price_in_dollars * sales.count
  end
end
