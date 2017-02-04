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

ActiveRecord::Schema.define(version: 20161224100803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action",         limit: 255
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type",      limit: 255
    t.string   "street",                limit: 255, null: false
    t.string   "street2",               limit: 255
    t.string   "city",                  limit: 255, null: false
    t.string   "state",                 limit: 255
    t.string   "zip_code",              limit: 255, null: false
    t.string   "country",               limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "approximate_latitude"
    t.float    "approximate_longitude"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
  add_index "addresses", ["approximate_latitude"], name: "index_addresses_on_approximate_latitude", using: :btree
  add_index "addresses", ["approximate_longitude"], name: "index_addresses_on_approximate_longitude", using: :btree

  create_table "advertisements", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "url",              limit: 255
    t.string   "image",            limit: 255
    t.integer  "impression_count"
    t.integer  "click_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position",         limit: 255, default: ""
  end

  add_index "advertisements", ["position"], name: "index_advertisements_on_position", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "slug",         limit: 255
    t.text     "excerpt"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id", "commentable_id"], name: "index_comments_on_user_id_and_commentable_id", unique: true, using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "code",              limit: 255
    t.string   "free_trial_length", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_followers", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "event_users", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "going",      default: false
    t.boolean  "not_going",  default: false
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "eventable_id"
    t.string   "eventable_type", limit: 255
    t.integer  "user_id"
    t.string   "title",          limit: 255
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "location",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",           limit: 255
    t.integer  "topic_id"
    t.integer  "priority",                   default: 50
  end

  add_index "events", ["eventable_id"], name: "index_events_on_eventable_id", using: :btree
  add_index "events", ["eventable_type"], name: "index_events_on_eventable_type", using: :btree
  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree
  add_index "events", ["topic_id"], name: "index_events_on_topic_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "focus_areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "forem_categories", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.integer  "position",               default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

  create_table "forem_forums", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count",             default: 0
    t.string  "slug",        limit: 255
    t.boolean "pinned",                  default: false
    t.integer "position",                default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

  create_table "forem_groups", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

  create_table "forem_memberships", force: :cascade do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

  create_table "forem_moderator_groups", force: :cascade do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

  create_table "forem_posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",            limit: 255, default: "approved"
    t.boolean  "notified",                     default: false
    t.string   "facebook_post_id", limit: 255
    t.string   "video"
    t.string   "image"
    t.string   "media"
  end

  add_index "forem_posts", ["facebook_post_id"], name: "index_forem_posts_on_facebook_post_id", using: :btree
  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

  create_table "forem_subscriptions", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                   default: false,      null: false
    t.boolean  "pinned",                   default: false
    t.boolean  "hidden",                   default: false
    t.datetime "last_post_at"
    t.string   "state",        limit: 255, default: "approved"
    t.integer  "views_count",              default: 0
    t.string   "slug",         limit: 255
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

  create_table "forem_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",                         default: 0
    t.string   "viewable_type",     limit: 255
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "group_sponsors", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "sponsor_logo_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_sponsors", ["group_id"], name: "index_group_sponsors_on_group_id", using: :btree
  add_index "group_sponsors", ["sponsor_logo_id"], name: "index_group_sponsors_on_sponsor_logo_id", using: :btree

  create_table "group_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "name",        limit: 255,                 null: false
    t.text     "description"
    t.string   "image",       limit: 255
    t.string   "cover_photo", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
    t.boolean  "sticky",                  default: false
    t.integer  "forum_id"
  end

  add_index "groups", ["forum_id"], name: "index_groups_on_forum_id", using: :btree
  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id", using: :btree
  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true, using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description"
    t.string   "image",        limit: 255
    t.boolean  "featured"
    t.date     "job_start_on"
    t.date     "job_end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company",      limit: 255
    t.string   "job_type",     limit: 255
    t.string   "industry",     limit: 255
    t.text     "company_bio"
    t.string   "company_url",  limit: 255
    t.boolean  "deleted",                  default: false
  end

  add_index "jobs", ["industry"], name: "index_jobs_on_industry", using: :btree
  add_index "jobs", ["job_type"], name: "index_jobs_on_job_type", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type", limit: 255
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.text     "body"
    t.string   "subject",              limit: 255, default: ""
    t.integer  "sender_id"
    t.string   "sender_type",          limit: 255
    t.integer  "conversation_id"
    t.boolean  "draft",                            default: false
    t.string   "notification_code",    limit: 255
    t.integer  "notified_object_id"
    t.string   "notified_object_type", limit: 255
    t.string   "attachment",           limit: 255
    t.datetime "updated_at",                                       null: false
    t.datetime "created_at",                                       null: false
    t.boolean  "global",                           default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type",   limit: 255
    t.integer  "notification_id",                             null: false
    t.boolean  "is_read",                     default: false
    t.boolean  "trashed",                     default: false
    t.boolean  "deleted",                     default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "media",      limit: 255
    t.string   "width",      limit: 255
    t.string   "height",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigation_links", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.string   "url",             limit: 255
    t.string   "navigation_menu", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "navigation_links", ["navigation_menu"], name: "index_navigation_links_on_navigation_menu", using: :btree

  create_table "news_feeds", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "feed_url",   limit: 255
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "sender_type",          limit: 255
    t.integer  "receiver_id"
    t.string   "receiver_type",        limit: 255
    t.integer  "notifiable_id"
    t.string   "notifiable_type",      limit: 255
    t.string   "action",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",                             default: false
    t.boolean  "checked",                          default: false
    t.integer  "attached_object_id"
    t.string   "attached_object_type"
    t.string   "url"
    t.text     "description"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "notifications", ["receiver_id", "receiver_type"], name: "index_notifications_on_receiver_id_and_receiver_type", using: :btree
  add_index "notifications", ["sender_id", "sender_type"], name: "index_notifications_on_sender_id_and_sender_type", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "slug",       limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "payola_affiliates", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "email",      limit: 255
    t.integer  "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_coupons", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.integer  "percent_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: true
  end

  create_table "payola_sales", force: :cascade do |t|
    t.string   "email",                 limit: 191
    t.string   "guid",                  limit: 191
    t.integer  "product_id"
    t.string   "product_type",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                 limit: 255
    t.string   "stripe_id",             limit: 255
    t.string   "stripe_token",          limit: 255
    t.string   "card_last4",            limit: 255
    t.date     "card_expiration"
    t.string   "card_type",             limit: 255
    t.text     "error"
    t.integer  "amount"
    t.integer  "fee_amount"
    t.integer  "coupon_id"
    t.boolean  "opt_in"
    t.integer  "download_count"
    t.integer  "affiliate_id"
    t.text     "customer_address"
    t.text     "business_address"
    t.string   "currency",              limit: 255
    t.text     "signed_custom_fields"
    t.integer  "owner_id"
    t.string   "owner_type",            limit: 100
    t.string   "stripe_customer_id",    limit: 191
    t.string   "paypal_payer_id",       limit: 255
    t.string   "paypal_express_token",  limit: 255
    t.string   "paypal_transaction_id", limit: 255
    t.string   "payment_source",        limit: 255, default: "stripe"
  end

  add_index "payola_sales", ["coupon_id"], name: "index_payola_sales_on_coupon_id", using: :btree
  add_index "payola_sales", ["email"], name: "index_payola_sales_on_email", using: :btree
  add_index "payola_sales", ["guid"], name: "index_payola_sales_on_guid", using: :btree
  add_index "payola_sales", ["owner_id", "owner_type"], name: "index_payola_sales_on_owner_id_and_owner_type", using: :btree
  add_index "payola_sales", ["payment_source"], name: "index_payola_sales_on_payment_source", using: :btree
  add_index "payola_sales", ["paypal_express_token"], name: "index_payola_sales_on_paypal_express_token", using: :btree
  add_index "payola_sales", ["paypal_payer_id"], name: "index_payola_sales_on_paypal_payer_id", using: :btree
  add_index "payola_sales", ["paypal_transaction_id"], name: "index_payola_sales_on_paypal_transaction_id", using: :btree
  add_index "payola_sales", ["product_id", "product_type"], name: "index_payola_sales_on_product", using: :btree
  add_index "payola_sales", ["stripe_customer_id"], name: "index_payola_sales_on_stripe_customer_id", using: :btree

  create_table "payola_stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_subscriptions", force: :cascade do |t|
    t.string   "plan_type",            limit: 255
    t.integer  "plan_id"
    t.datetime "start"
    t.string   "status",               limit: 255
    t.string   "owner_type",           limit: 255
    t.integer  "owner_id"
    t.string   "stripe_customer_id",   limit: 255
    t.boolean  "cancel_at_period_end"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "canceled_at"
    t.integer  "quantity"
    t.string   "stripe_id",            limit: 255
    t.string   "stripe_token",         limit: 255
    t.string   "card_last4",           limit: 255
    t.date     "card_expiration"
    t.string   "card_type",            limit: 255
    t.text     "error"
    t.string   "state",                limit: 255
    t.string   "email",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency",             limit: 255
    t.integer  "amount"
    t.string   "guid",                 limit: 191
    t.string   "stripe_status",        limit: 255
    t.integer  "affiliate_id"
    t.string   "coupon",               limit: 255
    t.text     "signed_custom_fields"
    t.text     "customer_address"
    t.text     "business_address"
    t.integer  "setup_fee"
  end

  add_index "payola_subscriptions", ["guid"], name: "index_payola_subscriptions_on_guid", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "postable_id",                                    null: false
    t.string   "postable_type", limit: 255,                      null: false
    t.integer  "author_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",         limit: 255, default: "approved"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["postable_id"], name: "index_posts_on_postable_id", using: :btree
  add_index "posts", ["postable_type"], name: "index_posts_on_postable_type", using: :btree
  add_index "posts", ["state"], name: "index_posts_on_state", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "price"
    t.string   "permalink",     limit: 255
    t.string   "name",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "redirect_path", limit: 255
  end

  create_table "regions", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "object_type", limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "radius",                  default: 500
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
  end

  add_index "regions", ["object_type"], name: "index_regions_on_object_type", using: :btree
  add_index "regions", ["slug"], name: "index_regions_on_slug", using: :btree

  create_table "reminder_logs", force: :cascade do |t|
    t.string   "log_type"
    t.integer  "object_id"
    t.string   "object_type"
    t.integer  "user_id"
    t.datetime "time_sent"
    t.text     "log"
  end

  create_table "root_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "media"
    t.text     "body"
    t.integer  "slide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "root_articles", ["slide_id"], name: "index_root_articles_on_slide_id", using: :btree
  add_index "root_articles", ["slug"], name: "index_root_articles_on_slug", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "slides", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "url",        limit: 255, default: ""
    t.integer  "use_url",                default: 0
  end

  create_table "special_offers", force: :cascade do |t|
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsor_logos", force: :cascade do |t|
    t.string  "image"
    t.string  "name"
    t.integer "default_status"
    t.string  "path"
  end

  create_table "stylesheets", force: :cascade do |t|
    t.boolean  "current"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "colors"
    t.string   "name",       limit: 255
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "amount"
    t.string   "currency",          limit: 255
    t.string   "interval",          limit: 255
    t.integer  "interval_count"
    t.integer  "trial_period_days"
    t.string   "stripe_id",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: :cascade do |t|
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tips", ["content"], name: "index_tips_on_content", using: :btree

  create_table "user_clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "website",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "image",      limit: 255
    t.text     "bio"
  end

  add_index "user_clients", ["user_id"], name: "index_user_clients_on_user_id", using: :btree

  create_table "user_focus_areas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "focus_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_focus_areas", ["focus_area_id"], name: "index_user_focus_areas_on_focus_area_id", using: :btree
  add_index "user_focus_areas", ["user_id"], name: "index_user_focus_areas_on_user_id", using: :btree

  create_table "user_followers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_followers", ["following_id"], name: "index_user_followers_on_following_id", using: :btree
  add_index "user_followers", ["user_id"], name: "index_user_followers_on_user_id", using: :btree

  create_table "user_reputations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "activity",    limit: 255
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "object_id"
    t.string   "object_type", limit: 255
  end

  add_index "user_reputations", ["object_id"], name: "index_user_reputations_on_object_id", using: :btree
  add_index "user_reputations", ["object_type"], name: "index_user_reputations_on_object_type", using: :btree
  add_index "user_reputations", ["user_id"], name: "index_user_reputations_on_user_id", using: :btree

  create_table "user_segmentations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_segmentations", ["user_id"], name: "index_user_segmentations_on_user_id", using: :btree
  add_index "user_segmentations", ["user_segment_id"], name: "index_user_segmentations_on_user_segment_id", using: :btree

  create_table "user_segments", force: :cascade do |t|
    t.integer  "position"
    t.string   "name",       limit: 255
    t.string   "ancestry",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_segments", ["ancestry"], name: "index_user_segments_on_ancestry", using: :btree
  add_index "user_segments", ["position"], name: "index_user_segments_on_position", using: :btree

  create_table "user_taggings", force: :cascade do |t|
    t.integer  "user_tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_taggings", ["user_id"], name: "index_user_taggings_on_user_id", using: :btree
  add_index "user_taggings", ["user_tag_id"], name: "index_user_taggings_on_user_tag_id", using: :btree

  create_table "user_tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255, default: "",                  null: false
    t.string   "encrypted_password",              limit: 255, default: "",                  null: false
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                               default: 0,                   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",              limit: 255
    t.string   "last_sign_in_ip",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",                        limit: 255
    t.string   "uid",                             limit: 255
    t.string   "first_name",                      limit: 255
    t.string   "last_name",                       limit: 255
    t.string   "image",                           limit: 255
    t.string   "gender",                          limit: 255
    t.string   "facebook_url",                    limit: 255
    t.string   "education",                       limit: 255
    t.string   "work",                            limit: 255
    t.text     "website"
    t.text     "about"
    t.string   "cover_photo",                     limit: 255
    t.string   "slug",                            limit: 255
    t.boolean  "admin",                                       default: false
    t.boolean  "forem_admin",                                 default: false
    t.string   "forem_state",                     limit: 255, default: "approved"
    t.boolean  "forem_auto_subscribe",                        default: false
    t.string   "access_token",                    limit: 255
    t.datetime "access_token_expires_at"
    t.string   "twitter_username",                limit: 255
    t.string   "linked_in",                       limit: 255
    t.string   "google_plus_id",                  limit: 255
    t.integer  "primary_segment_id"
    t.integer  "secondary_segment_id"
    t.string   "phone_number",                    limit: 255
    t.string   "pinterest_username",              limit: 255
    t.string   "resume",                          limit: 255
    t.string   "state",                           limit: 255, default: "onboarding_groups"
    t.boolean  "auto_follow",                                 default: false
    t.string   "social_link_vine",                limit: 255
    t.string   "social_link_youtube",             limit: 255
    t.string   "social_link_tumblr",              limit: 255
    t.string   "social_link_custom_facebook_url", limit: 255
    t.string   "social_link_instagram",           limit: 255
    t.string   "social_link_whatsapp",            limit: 255
    t.string   "social_link_snapchat",            limit: 255
    t.integer  "roles_mask"
    t.boolean  "notification_by_email",                       default: false
    t.datetime "last_seen"
    t.string   "company_name"
    t.string   "title"
    t.boolean  "event_notification",                          default: true
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["primary_segment_id"], name: "index_users_on_primary_segment_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["secondary_segment_id"], name: "index_users_on_secondary_segment_id", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

  create_table "users_online_logs", force: :cascade do |t|
    t.integer  "user_ids",    default: [], null: false, array: true
    t.integer  "users_count", default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "zip_code_locations", force: :cascade do |t|
    t.integer  "zip_code",   null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_code_locations", ["zip_code"], name: "index_zip_code_locations_on_zip_code", unique: true, using: :btree

  add_foreign_key "group_sponsors", "groups"
  add_foreign_key "group_sponsors", "sponsor_logos"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
