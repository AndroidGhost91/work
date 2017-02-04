module HasAddress
  extend ActiveSupport::Concern

  module ClassMethods
    def has_address(name, scope = nil, options = {})
      has_one name, scope, :as => :addressable, :dependent => :destroy
      accepts_nested_attributes_for name, options
    end
  end
end
