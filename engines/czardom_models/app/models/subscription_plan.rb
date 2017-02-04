class SubscriptionPlan < ActiveRecord::Base
  include Payola::Plan

  before_validation :set_stripe_id

  def price
    return 0 if amount.nil?
    self.amount / 100.0
  end

  def price=(new_price)
    self.amount = (new_price * 100.0).to_i
  end

  private

  def set_stripe_id
    self.stripe_id = name.parameterize unless self.stripe_id.present?
  end
end
