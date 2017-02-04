class UsersController < ApplicationController
  skip_before_action :onboard_override, only: [:edit, :update]
  load_and_authorize_resource except: [:new, :create]
  skip_before_action :verify_authenticity_token, only: [:create, :update]
  before_action :check_confirmable, only: [:show, :edit]

  respond_to :html

  def new
    # redirect_to root_path and return if session['devise.facebook_data'].blank?

    if session['devise.facebook_data'].blank?
      @user = User.new
      @user.email = params[:email]
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
    else
      @user = User.from_omniauth(Hashie::Mash.new(session['devise.facebook_data']))
    end
    @user.build_address if @user.address.blank?
    respond_with @user
  end

  def create
    @user = User.new(user_params)

    unless session['devise.facebook_data'].blank?
      @user.password = @user.password_confirmation = Devise.friendly_token[0,20]
      @user.provider = 'facebook'
      @user.uid = session["devise.facebook_data"]['uid']
      @user.skip_confirmation!
    end
    
    @user.state = 'onboarding_groups'

    if @user.save
      @user.following_users << User.where(auto_follow: true)

      sign_in @user
    end

    respond_with @user
  end

  def show
    @user = @user.decorate
    @recommend_user = User.find(params[:id])
    @new_comment    = Comment.build_from(@recommend_user, current_user.id, "")
    @comments = Comment.where(commentable_id: @user.id)
    respond_with @user
  end

  def edit
    @user = current_user if @user.blank?
    @user.build_address if @user.address.blank?
    respond_with @user
  end

  def edit_clients
    @user = current_user if @user.blank?
    @user.clients.build
    respond_with @user
  end

  def edit_groups
    @user = current_user if @user.blank?
    respond_with @user
  end

  def edit_password
    @user = current_user if @user.blank?
    respond_with @user
  end

  def update
    if @user.update_attributes(user_params)
      respond_with @user
    else
      action = params[:user_action]
      if action == 'edit_password'
        render :edit_password
      else
        render :edit
      end
    end
  end

  def image
    redirect_to @user.image_url(:small)
    # image = open(@user.image_url(:small))
    # send_data image.read, type: image.content_type, disposition: :inline, x_sendfile: true
  end

  def blurbs
    users = User.where(id: params[:ids])
    response = {}

    users.each do |user|
      response[user.id] = {
        full_name: user.full_name,
        slug: user.slug_url,
        avatar: user.image_url(:small),
        about: user.about
      }
    end

    render json: response
  end

  def follow
    @following_user = User.find(params[:user_id])
    
    if current_user.following?(@following_user)
      current_user.unfollow @following_user
    else
      current_user.follow @following_user
    end
  end
  
  def followed
    @following_users = current_user.following_users
    unless params[:search].blank?
      @following_users = search_user(@following_users, "%#{params[:search]}%")
    end
    @following_users = @following_users.page(params[:page]).per(10)
  end
  
  def followers
    @followers = User.where(id: current_user.followers.pluck(:id))
    unless params[:search].blank?
      @followers = search_user(@followers, "%#{params[:search]}%")
    end
    @followers = @followers.page(params[:page]).per(10)
  end

  def posts
    @posts = Forem::Post.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def all_czars
    @users = User.all
    unless params[:search].blank?
      @users = search_user(@users, "%#{params[:search]}%")
    end
     @users = @users.page(params[:page]).per(10)
  end

  private

  def search_user(users, text_search)
    text = text_search.to_s.downcase
    users.where("lower(first_name) || ' ' || lower(last_name) like :s", :s => "%#{text}")
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :about, :resume, :slug,
      :company_name, :title,
      :notification_by_email,
      :event_notification,
      :image, :cover_photo,
      :education, :work, :facebook_url, :website,
      :image_cache, :cover_photo_cache,
      :twitter_username, :linked_in, :google_plus_id, :pinterest_username,
      :social_link_custom_facebook_url, :social_link_vine, :social_link_youtube, :social_link_tumblr,
      :social_link_instagram, :social_link_snapchat, :social_link_whatsapp,
      :primary_segment_id,
      :user_segment_ids => [],
      :focus_area_ids => [],
      :group_ids => [],
      :clients_attributes => [:id, :name, :website, :image, :bio, :position, :_destroy],
      :address_attributes => [:street, :street2, :city, :state, :zip_code, :country, :id]
    )
  end
  def recommend
  end
end
