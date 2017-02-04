module CzardomEvents
  class EventsController < EventsApplicationController
    before_action :find_event, only: [:show, :join, :leave]
    load_and_authorize_resource

    def follow
      event = Event.find(params[:event_id].to_i)
      user_id = params[:user_id].to_i
      if event.can_follow(user_id)
        event_follower = event.event_followers.where(user_id: user_id).first
        event_follower.destroy!
      else
        event.event_followers.create(user_id: user_id)
      end
      redirect_to event_path(event)
    end

    def index
      @events = @events.order(:start_at)
      @event_followings = Event.where(id: current_user.event_followers.pluck(:event_id))

      if params[:regions].present?
        regions = Region.find(params[:regions])
        event_ids = regions.map { |r| r.results.map(&:addressable_id) }.flatten.uniq
        @events.where!(id: event_ids)
        @event_followings.where!(id: event_ids)
      end

      if params[:groups].present?
        @events.where!(eventable_type: 'Group', eventable_id: params[:groups])
        @event_followings.where!(eventable_type: 'Group', eventable_id: params[:groups])
      end

      if params[:date].present?
        @events.where!('date(start_at) = ?', params[:date])
        @event_followings.where!('date(start_at) = ?', params[:date])
      else
        @events = @events.current
        @event_followings = @event_followings.current
      end

      # should not include duplicate events
      @event_followings = @event_followings.where("id NOT IN (?)", @events.pluck(:id))
      @events += @event_followings

      respond_with @events
    end

    def count_by_day
      start = params[:start]
      stop = params[:end]
      @events = Event.all

      if params[:regions].present?
        regions = Region.find(params[:regions])
        event_ids = regions.map { |r| r.results.map(&:addressable_id) }.flatten.uniq
        @events.where!(id: event_ids)
      end

      if params[:groups].present?
        @events.where!(eventable_type: 'Group', eventable_id: params[:groups])
      end

      @events = @events.reorder(nil)
        .group('date(start_at)')
        .where('date(start_at) >= ? and date(start_at) <= ?', start, stop)
        .count
      respond_with @events
    end

    def show
      @posts = @event.topic.posts.limit(5)
    end

    def new
      @event.build_address
    end

    def create
      @event = Event.new(event_params)
      @event.user = current_user
      @event.eventable = eventable

      if @event.save
        if eventable.class.name == 'User'
          create_user_events_topic(@event)
        elsif eventable.class.name == 'Group'
          create_group_events_topic(eventable, @event)
        end
       
        # track_activity @event
       # Event.add_user(@event.id, current_user.id)
        redirect_to @event
      else
        render :new
      end
    end

    def update
      @event.eventable = eventable

      unless @event.topic_id.present?
        if eventable.class.name == 'User'
          create_user_events_topic(@event)
        elsif eventable.class.name == 'Group'
          create_group_events_topic(eventable, @event)
        end
      end

      @event.update_attributes(event_params)
      redirect_to @event
    end

    def destroy
      @event.destroy
      redirect_to root_path
    end

    def join
      Event.add_user(@event.id, current_user.id)
      # track_activity @event, 'rsvp'
      redirect_to event_path(params[:id])
    end

    def leave
      Event.remove_user(params[:id], current_user.id)
      redirect_to event_path(params[:id])
    end

    private

    def event_params
      params.require(:event).permit(
        :title, :description,
        :start_at, :end_at, :timeframe,
        :location,
        :address_attributes => [:street, :street2, :city, :state, :zip_code, :country, :id]
      )
    end

    def eventable
      return @postable unless @postable.nil?
      group_id = params.fetch(:group_id, false)
      if group_id.present?
        @postable = Group.find(group_id)
      else
        @postable = current_user
      end
    end

    def find_event
      @event ||= Event.friendly.find(params[:id])
    end

    def create_user_events_topic(event)
      ActiveRecord::Base.transaction do
        category = Forem::Category.find_or_create_by!(name: 'General')

        unless forum = Forem::Forum.find_by(name: 'User Events')
          forum = Forem::Forum.create!(name: 'User Events', description: "See what's coming up in the PR world", category: category)
        end

        topic = forum.topics.create!(
          subject: "Event: #{event.title}",
          user: current_user,
          posts_attributes: [{
            text: %Q{#{event.description}<br /><br /><a href="#{event_url(event)}">#{event_url(event)}</a>},
            notified: true
          }]
        )

        event.update_attributes(topic_id: topic.id)
      end
    end

    def create_group_events_topic(group, event)
      ActiveRecord::Base.transaction do
        group.create_forum
        forum = group.forum

        topic = forum.topics.create!(
          subject: "Event: #{event.title}",
          user: current_user,
          posts_attributes: [{
            text: %Q{#{event.description}<br /><br /><a href="#{event_url(event)}">#{event_url(event)}</a>},
            notified: true
          }]
        )

        event.update_attributes(topic_id: topic.id)
      end
    end


  end
end
