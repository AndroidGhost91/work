# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150706151738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "addresses", force: true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "street",           null: false
    t.string   "street2"
    t.string   "city",             null: false
    t.string   "state"
    t.string   "zip_code",         null: false
    t.string   "country",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree

  create_table "advertisements", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "image"
    t.integer  "impression_count"
    t.integer  "click_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position",         default: ""
  end

  add_index "advertisements", ["position"], name: "index_advertisements_on_position", using: :btree

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "excerpt"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", using: :btree

  create_table "coupons", force: true do |t|
    t.string   "code"
    t.string   "free_trial_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_users", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "going",      default: false
    t.boolean  "not_going",  default: false
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "topic_id"
  end

  add_index "events", ["eventable_id"], name: "index_events_on_eventable_id", using: :btree
  add_index "events", ["eventable_type"], name: "index_events_on_eventable_type", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["topic_id"], name: "index_events_on_topic_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "focus_areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "forem_categories", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

  create_table "forem_forums", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", default: 0
    t.string  "slug"
    t.boolean "pinned",      default: false
    t.integer "position",    default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

  create_table "forem_groups", force: true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

  create_table "forem_memberships", force: true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

  create_table "forem_moderator_groups", force: true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

  create_table "forem_posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",            default: "approved"
    t.boolean  "notified",         default: false
    t.string   "facebook_post_id"
  end

  add_index "forem_posts", ["facebook_post_id"], name: "index_forem_posts_on_facebook_post_id", using: :btree
  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

  create_table "forem_subscriptions", force: true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",       default: false,      null: false
    t.boolean  "pinned",       default: false
    t.boolean  "hidden",       default: false
    t.datetime "last_post_at"
    t.string   "state",        default: "approved"
    t.integer  "views_count",  default: 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

  create_table "forem_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             default: 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "group_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer  "owner_id"
    t.string   "name",                        null: false
    t.text     "description"
    t.string   "image"
    t.string   "cover_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "sticky",      default: false
    t.integer  "forum_id"
  end

  add_index "groups", ["forum_id"], name: "index_groups_on_forum_id", using: :btree
  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id", using: :btree
  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true, using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.boolean  "featured"
    t.date     "job_start_on"
    t.date     "job_end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company"
    t.string   "job_type"
    t.string   "industry"
    t.text     "company_bio"
    t.string   "company_url"
    t.boolean  "deleted",      default: false
  end

  add_index "jobs", ["industry"], name: "index_jobs_on_industry", using: :btree
  add_index "jobs", ["job_type"], name: "index_jobs_on_job_type", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "media", force: true do |t|
    t.string   "title"
    t.string   "media"
    t.string   "width"
    t.string   "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigation_links", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "navigation_menu"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "navigation_links", ["navigation_menu"], name: "index_navigation_links_on_navigation_menu", using: :btree

  create_table "news_feeds", force: true do |t|
    t.string   "title"
    t.string   "feed_url"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",            default: false
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "notifications", ["receiver_id", "receiver_type"], name: "index_notifications_on_receiver_id_and_receiver_type", using: :btree
  add_index "notifications", ["sender_id", "sender_type"], name: "index_notifications_on_sender_id_and_sender_type", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "postable_id",                        null: false
    t.string   "postable_type",                      null: false
    t.integer  "author_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",         default: "approved"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["postable_id"], name: "index_posts_on_postable_id", using: :btree
  add_index "posts", ["postable_type"], name: "index_posts_on_postable_type", using: :btree
  add_index "posts", ["state"], name: "index_posts_on_state", using: :btree

  create_table "products", force: true do |t|
    t.integer  "price"
    t.string   "permalink"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "redirect_path"
  end

  create_table "regions", force: true do |t|
    t.string   "title"
    t.string   "object_type"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "radius",      default: 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["object_type"], name: "index_regions_on_object_type", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "slides", force: true do |t|
    t.string   "image"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "url",        default: ""
  end

  create_table "stylesheets", force: true do |t|
    t.boolean  "current"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "colors"
    t.string   "name"
  end

  create_table "subscription_plans", force: true do |t|
    t.string   "name"
    t.integer  "amount"
    t.string   "currency"
    t.string   "interval"
    t.integer  "interval_count"
    t.integer  "trial_period_days"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_clients", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "image"
    t.text     "bio"
  end

  add_index "user_clients", ["user_id"], name: "index_user_clients_on_user_id", using: :btree

  create_table "user_focus_areas", force: true do |t|
    t.integer  "user_id"
    t.integer  "focus_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_focus_areas", ["focus_area_id"], name: "index_user_focus_areas_on_focus_area_id", using: :btree
  add_index "user_focus_areas", ["user_id"], name: "index_user_focus_areas_on_user_id", using: :btree

  create_table "user_followers", force: true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_followers", ["following_id"], name: "index_user_followers_on_following_id", using: :btree
  add_index "user_followers", ["user_id"], name: "index_user_followers_on_user_id", using: :btree

  create_table "user_reputations", force: true do |t|
    t.integer  "user_id"
    t.string   "activity"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "object_id"
    t.string   "object_type"
  end

  add_index "user_reputations", ["object_id"], name: "index_user_reputations_on_object_id", using: :btree
  add_index "user_reputations", ["object_type"], name: "index_user_reputations_on_object_type", using: :btree
  add_index "user_reputations", ["user_id"], name: "index_user_reputations_on_user_id", using: :btree

  create_table "user_segmentations", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_segmentations", ["user_id"], name: "index_user_segmentations_on_user_id", using: :btree
  add_index "user_segmentations", ["user_segment_id"], name: "index_user_segmentations_on_user_segment_id", using: :btree

  create_table "user_segments", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_segments", ["ancestry"], name: "index_user_segments_on_ancestry", using: :btree
  add_index "user_segments", ["position"], name: "index_user_segments_on_position", using: :btree

  create_table "user_taggings", force: true do |t|
    t.integer  "user_tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_taggings", ["user_id"], name: "index_user_taggings_on_user_id", using: :btree
  add_index "user_taggings", ["user_tag_id"], name: "index_user_taggings_on_user_tag_id", using: :btree

  create_table "user_tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                           default: "",                  null: false
    t.string   "encrypted_password",              default: "",                  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,                   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "gender"
    t.string   "facebook_url"
    t.string   "education"
    t.string   "work"
    t.text     "website"
    t.text     "about"
    t.string   "cover_photo"
    t.string   "slug"
    t.boolean  "admin",                           default: false
    t.boolean  "forem_admin",                     default: false
    t.string   "forem_state",                     default: "approved"
    t.boolean  "forem_auto_subscribe",            default: false
    t.string   "access_token"
    t.datetime "access_token_expires_at"
    t.string   "twitter_username"
    t.string   "linked_in"
    t.string   "google_plus_id"
    t.integer  "primary_segment_id"
    t.integer  "secondary_segment_id"
    t.string   "phone_number"
    t.string   "pinterest_username"
    t.string   "resume"
    t.string   "state",                           default: "onboarding_groups"
    t.boolean  "auto_follow",                     default: false
    t.string   "social_link_vine"
    t.string   "social_link_youtube"
    t.string   "social_link_tumblr"
    t.string   "social_link_custom_facebook_url"
    t.string   "social_link_instagram"
    t.string   "social_link_whatsapp"
    t.string   "social_link_snapchat"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["primary_segment_id"], name: "index_users_on_primary_segment_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["secondary_segment_id"], name: "index_users_on_secondary_segment_id", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

  create_table "users_online_logs", force: true do |t|
    t.integer  "user_ids",    default: [], null: false, array: true
    t.integer  "users_count", default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "zip_code_locations", force: true do |t|
    t.integer  "zip_code",   null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_code_locations", ["zip_code"], name: "index_zip_code_locations_on_zip_code", unique: true, using: :btree

  # add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  # add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  # add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
