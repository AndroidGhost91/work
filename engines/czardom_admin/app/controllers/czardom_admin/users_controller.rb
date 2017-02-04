module CzardomAdmin
  class UsersController < AdminController
    load_and_authorize_resource
    skip_authorize_resource only: :destroy

    def index
      @title = 'Users'
      @users = User.order(:first_name).where('email not like ?', '%fb-user-id.com').where('created_at is not null')
      
      @user_address = {}
      Address.where(addressable_type: 'User').each do |add|
        @user_address[:"#{add.addressable_id}"] = {city: add.city, state: add.state}
      end

      if params[:time]
        @title = get_title(params[:time])

        case params[:time]
        when 'today'
          @users = @users.where('extract(year from created_at) = ?', Time.now.year)
            .where('extract(doy from created_at) = ?', Time.now.strftime('%j'))
        when 'week'
          @users = @users.where('extract(year from created_at) = ?', Time.now.year)
            .where('extract(week from created_at) = ?', Time.now.strftime('%W'))
        when 'last-week'
          @users = @users.where('extract(year from created_at) = ?', Time.now.year)
            .where('extract(week from created_at) = ?', 1.week.ago.strftime('%W'))
        end
      end

      respond_to do |f|
        f.html
        f.csv do
          @users = @users.includes(:address).includes(:sales)
          send_data CsvGenerator.new(@users, User::EXPORT_ATTRIBUTES).export_csv, filename: "users-#{Date.today}.csv"
        end
      end
    end

    def show
      respond_with @user
    end

    def impersonate
      sign_in @user
      redirect_to main_app.root_path
    end

    def new
      respond_with @user
    end

    def create
      @user.save(validate: false)
      respond_with @user
    end

    def edit
      respond_with @user
    end

    def update
      @user.assign_attributes(user_params)
      @user.save(validate: false)
      respond_with @user
    end

    def destroy
      if current_ability.can? :change_account_status, @user
        User.transaction do
          Forem::Topic.where(user_id: @user.id).destroy_all
          @user.destroy
        end
        msg = {notice: "Destroy user #{@user.full_name} successful!"}
      else
        msg = {alert: "You don't have rights to destroy user"}
      end
      redirect_to root_path, msg
    end

    private

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :about, :resume, :slug,
        :image, :cover_photo,
        :education, :work, :facebook_url, :website,
        :image_cache, :cover_photo_cache,
        :twitter_username, :linked_in, :google_plus_id, :pinterest_username,
        :social_link_custom_facebook_url, :social_link_youtube, :social_link_tumblr,
        #, :social_link_vine
        :social_link_instagram, :social_link_snapchat, :social_link_whatsapp,
        :primary_segment_id,
        :admin,
        :user_segment_ids => [],
        :focus_area_ids => [],
        :group_ids => [],
        :clients_attributes => [:id, :name, :website, :image, :bio, :position, :_destroy],
        :address_attributes => [:street, :street2, :city, :state, :zip_code, :country, :id],
        :roles => []
      )
    end

    def get_title(timespan)
      case timespan
      when 'today'
        'New Users Today'
      when 'week'
        'New Users This Week'
      when 'last-week'
        'New Users Last Week'
      else
        'Users'
      end
    end

  end
end
