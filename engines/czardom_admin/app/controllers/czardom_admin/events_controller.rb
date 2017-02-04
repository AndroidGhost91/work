module CzardomAdmin
  class EventsController < AdminController
    load_and_authorize_resource

    def index
      @events.order!('end_at DESC')
      active_event_date = Time.parse(params[:filter_active_event_at]) unless params[:filter_active_event_at].blank?
      start_at = Time.parse(params[:filter_start_at]) unless params[:filter_start_at].blank?
      end_at = Time.parse(params[:filter_end_at]) unless params[:filter_end_at].blank?
      @events = @events.where("start_at >= ? ", start_at.utc.change(min: 0, hour: 0, sec: 0)) if start_at
      @events = @events.where("end_at <= ? ", end_at.utc.change(min: 0, hour: 0, sec: 0)) if end_at
      if active_event_date
        date = active_event_date.utc.change(min: 0, hour: 0, sec: 0)
        @events = @events.where("start_at <= ? AND end_at >= ? ", date, date)
      end
      @events = @events.page(params[:page]).per(10)
      respond_with @events
    end

    def show
      respond_with @event
    end

    def new
      respond_with @event
    end

    def create
      @event.save
      respond_with @event
    end

    def edit
      respond_with @event
    end

    def update
      @event.update_attributes(event_params)
      respond_with @event
    end

    def destroy
      @event.destroy
      redirect_to events_path
    end

    private

    def event_params
      params.require(:event).permit(:title, :description, :priority, :start_at, :end_at)
    end

  end
end