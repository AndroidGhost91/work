class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  validates_presence_of :city, unless: proc { |a| %w(Group).include?(a.addressable_type) }

  validates_presence_of :street, :zip_code, unless: proc { |a| %w(User Group).include?(a.addressable_type) }

  geocoded_by :full_address
  after_validation :geocode_addresses, if: :address_changed?

  def to_builder
    Jbuilder.new do |address|
      address.street street
      address.street2 street2
      address.city city
      address.state state.upcase
      address.country country
      address.zip_code zip_code
    end
  end

  def geocode_addresses
    actual_coordinates = Geocoder.search(full_address).first
    approximate_coordinates = Geocoder.search(city_state).first

    unless actual_coordinates.nil?
      self.latitude = actual_coordinates.latitude
      self.longitude = actual_coordinates.longitude
    end

    unless approximate_coordinates.nil?
      self.approximate_latitude = approximate_coordinates.latitude
      self.approximate_longitude = approximate_coordinates.longitude
    end
  end

  def city_state
    [city, state, country, zip_code].reject(&:blank?).join(' ')
  end

  def full_address
    [street, street2, city, state, country, zip_code].reject(&:blank?).join(', ')
  end

  def address_changed?
    street_changed? || street2_changed? || city_changed? || state_changed? || country_changed? || zip_code_changed?
  end
end
