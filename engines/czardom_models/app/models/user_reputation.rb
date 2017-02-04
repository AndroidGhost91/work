class UserReputation < ActiveRecord::Base
  # USER AMOUNTS
  NEW_FOLLOWER_AMOUNT = 5

  # POST AMOUNTS
  CREATED_POST_AMOUNT = 2
  LIKED_POST_AMOUNT = 1
  FLAGGED_POST_AMOUNT = -3

  belongs_to :user
  belongs_to :object, polymorphic: true

  def self.create_post(post)
    create!({
      activity: 'created post',
      object: post,
      amount: CREATED_POST_AMOUNT
    })
  end

  def self.flag_post(post)
    create!({
      activity: 'flagged post',
      object: post,
      amount: FLAGGED_POST_AMOUNT
    })
  end

  def self.new_follower(follower)
    create!({
      activity: 'new follower',
      object: follower,
      amount: NEW_FOLLOWER_AMOUNT
    })
  end
end
