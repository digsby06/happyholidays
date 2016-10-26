module Api
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]

    thr = Thread.new {
          puts "thread"
          timer
          puts "timer is running"
      }
    $last_play_time = Time.now

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


        # Mixpanel is used to track each time a gesture event is triggered
          require "mixpanel-ruby"
          tracker = Mixpanel::Tracker.new("9ae4dc350f5c0a7ccf5a0cff913c4a4d")
          tracker.track(@event.id, 'Event Triggered')

          can_play = true
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


    def self.start_ambient_mode
      puts 'Now Starting Ambient Mode'
      Event.start_show
    end

    def self.timer
      puts 'Inside the timer block'
      @@time_check_never_stop = true
      puts @@time_check_never_stop
        while @@time_check_never_stop
            puts 'loop is working'
            compare_time
            sleep(5)
            puts 'Time Compared'
        end
        puts "test123"
    end


    def self.compare_time
      puts 'inside time comparison block'
      time = Time.now
      puts time
      puts $last_play_time + 30
      if time >= ($last_play_time + 30)
        puts 'Enough time has passed without an event'
        start_ambient_mode
      else
        puts 'Not this time'
      end

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
