class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:fetch_facebook_comments]
  before_action :check_confirmable, only: [:feed]

  def feed
    # .where('forum_id <> (select id from forem_forums where slug = ?)', 'facebook')
    load_topics_for_home
    @sliders = Slide.order(:position).last(10)
  end

  def board
    load_topics_for_home
    render :feed
  end

  def following
    @topics = Forem::Topic
      .by_most_recent_post
      .approved
      .where(id: Forem::Subscription.where(subscriber_id: (current_user.following_user_ids | [current_user.id])).pluck(:topic_id))
      .page(params[:page]).per(30)

    render :feed
  end

  def new
  end
  
  def root_article
    @root_article = RootArticle.find(params[:id])
    @slide = @root_article.slide
    @urls = [];
    @video_url = nil;

    unless @root_article.media.nil? or @root_article.media == ""
      
      url_obj = JSON(@root_article.media)
    
        url_obj.each do |index, data|
     
        if index != "5" 
           @urls.push(data["url"]);
        else 
          @video_url = data["url"];
        end
    
      end
    end

  end
 
  def create
 
    if params[:commit] == "Post a story" then 
      create_post
    else
      # create_post_discussion
    end
  end 
  
  def create_post
    #create new topic, post 
    # Remove new lines and replace with a space
    topic_title = params[:body].gsub( /\n/m, " " )
    topic_title = topic_title[0,175]
    forum = Forem::Forum.find_by_name(params[:location])
    topic = forum.topics.create({
    user: current_user,
    subject: topic_title,
    slug: topic_title.parameterize,
    posts_attributes: [{
      user: current_user,
      text: params[:body],
      media: params[:media_url],
      facebook_post_id: nil
      }]
    })
    if params[:back_to_board] 
      redirect_to board_path
    else
      redirect_to forem.forum_topic_path(forum, topic)
    end
  end

  def create_post_discussion  
    # 1. find forum from selection
    forum = find_forum_from_location(params[:location])
    fb_post = {}
    
    topic_title = params[:body].gsub( /\n/m, " " )
    topic_title = topic_title[0,175]
    
    topic = forum.topics.create({
      user: current_user,
      subject: topic_title,
      slug: params[:slug],
      posts_attributes: [{
        user: current_user,
        text: params[:body],
        facebook_post_id: fb_post.fetch('id', nil)
      }]
    })
    redirect_to forem.forum_topic_path(forum, topic)
  end

  # Kaminari defaults page_method_name to :page, will_paginate always uses
  # :page
  def pagination_method
    Kaminari.config.page_method_name
  end
  # Kaminari defaults param_name to :page, will_paginate always uses :page
  def pagination_param
    Kaminari.config.param_name
  end
  helper_method :pagination_param

  def forem_admin_or_moderator?(forum)
    false
  end
  helper_method :forem_admin_or_moderator?

  private

  def load_topics_for_home
    @topics = Forem::Topic
      .by_most_recent_post
      .approved
      .page(params[:page]).per(10)
      # @topics = Forem::Topic
      #   .where(:forum_id => 28)
      #   .by_most_recent_post
      #   .approved
      #   .page(params[:page]).per(30)
  end

  def find_forum_from_location(location)
    id = case location.downcase
         when 'who reps'
           'pr-contacts'
         when 'events'
           'user-events'
         when 'vendors and venues'
           'vendors-and-venues'
         when 'pr resources'
           'pr-resources'
         end

    Forem::Forum.find(id)
  end
end
