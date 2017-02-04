# NO USING ANYMORE
# USING FOREM::POST

# class Post < ActiveRecord::Base
  #   default_scope lambda { where.not(state: 'marked_as_spam') }

  #   belongs_to :postable, polymorphic: true
  #   belongs_to :author, class_name: 'User'
  #   delegate :image_url, :full_name, to: :author, prefix: :author

  #   has_many :comments, as: :postable, dependent: :destroy

  #   state_machine :initial => :approved do
  #     state :approved
  #     state :flagged_for_spam
  #     state :marked_as_spam

  #     event :approve do
  #       transition all => :approved
  #     end

  #     event :flag_for_spam do
  #       transition all => :flagged_for_spam
  #     end

  #     event :mark_as_spam do
  #       transition all => :marked_as_spam
  #     end
  #   end
# end