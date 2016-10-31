class Event < ApplicationRecord
  include HTTParty

  @@last_play_time = Time.now

  def self.start_show

    puts 'The Show has started'

    # Play Audio Track
    # if vlc.connected? == false
    #   vlc = VLC::System.new
    # end
    # vlc.play('https://att_holiday.dev/assets/audios/4936.mp3')
    puts 'Playing Audio - check!'
    # Connect to Stratacache

    # HTTParty.post('http://<local_IP>:3002/multikiosk/start',
    #   :body =>  { :trigger => '1'}. to_json,
    #   :headers => {'Content-Type' => 'application/json'})

    puts 'Playing Stratacache Content - check!'

    # Connect to Cue server to start light show

    # sock = UDPSocket.new
    # data = 'something to be determined'
    # sock.send(data, 0, '172.16.2.210', 52737 )
    # sock.close

    # Resets the last_play_time
    @@last_play_time = Time.now
    puts 'The Show has ended'
  end

  def self.start_ambient_mode
        puts 'Now Starting Ambient Mode'
        start_show
  end

  def self.timer

    @@time_check_never_stop = true

    puts @@time_check_never_stop

      while @@time_check_never_stop
          compare_time
          sleep(5)
      end

  end


  def self.compare_time
    puts 'Comparing Time'
    time = Time.now
    puts time
    puts @@last_play_time + (60 * 22)
    if time >= (@@last_play_time + (60 * 22))
      puts 'Enough time has passed without an event, start Ambient Mode'
      start_ambient_mode
    else
      puts 'Waiting for event'
    end

  end


end
