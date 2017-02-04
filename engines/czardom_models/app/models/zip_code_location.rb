class ZipCodeLocation < ActiveRecord::Base
  geocoded_by :zip_code
  after_validation :geocode

  validates_presence_of :zip_code
  validates_uniqueness_of :zip_code

  def self.search(zip)
    find_or_create_by!(zip_code: zip)
  end
end
