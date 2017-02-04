class Job < ActiveRecord::Base
  include HasAddress
  mount_uploader :image, ImageUploader

  default_scope lambda { where(deleted: false) }

  has_address :address

  def full_name
    [company, title].join(' - ')
  end

  # Finds all current job openings for the current date.
  #
  #   Job.current #=> [Job, Job, Job, ...]
  def self.current
    where('job_start_on < ?', Date.today)
    .where('job_end_on > ?', Date.today)
  end

  def location
    if address.present?
      "%s, %s" % [address.city, address.state]
    else
      "N/A"
    end
  end
end
