module Api
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]

    # GET /events
    def index
      @events = Event.all
      render json: @events , status: 200
    end

    # GET /events/1
    def show
      render json: @event.trigger , status: 200
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      can_play = true

      if @event.save

        if can_play == true

          can_play = false

          Event.start_show
          mixpanel_track_event

          can_play = true
        end

        end
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end


    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
    end

    def self.mixpanel_track_event
      # Mixpanel is used to track each time a gesture event is triggered
        require "mixpanel-ruby"
        tracker = Mixpanel::Tracker.new("9ae4dc350f5c0a7ccf5a0cff913c4a4d")
        tracker.track(@event.id, 'Event Triggered')
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:trigger)
      end
  end
end
