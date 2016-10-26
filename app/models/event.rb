class Event < ApplicationRecord

  def self.start_show

    puts 'The Show has started'
    # Play Audio Track
    # if vlc.connected? == false
    #   vlc = VLC::System.new
    # end
    # vlc.play('https://att_holiday.dev/assets/audios/4936.mp3')

    # Connect to Stratacache

      # Waiting for information - Place code here

    # Connect to Cue server to start light show

    # sock = UDPSocket.new
    # data = 'something to be determined'
    # sock.send(data, 0, '172.16.2.210', 52737 )
    # sock.close

    $last_play_time = Time.now
    puts 'The Show has ended'
    puts $last_play_time
  end


end
