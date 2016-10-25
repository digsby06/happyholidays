namespace :happyholidays do
  desc 'Search for Twitter Hashtags'
  task :tweetstreamer => :environment do
    require 'tweetstream'
    require 'twitter'
    require 'mixpanel-ruby'

      TweetStream.configure do |conf|
        conf.consumer_key        = "WBIuUgFwoOZNmWDk0FkveW9xi"
        conf.consumer_secret     = "VxmRSeOZANjYMmP45Cy8mnIUwzb0cux7PvGI8biuTLGzoMDUUt"
        conf.oauth_token        =  "785500627703136257-LRMvMpJvNhTVVE0NmZIeOUBtKY0WC0Z"
        conf.oauth_token_secret = "Q76Y8avuFt0Txi8WQF6sYszuQj7SvsBNGFKobeGbO9C1f"
        conf.auth_method         = :oauth
      end
      @store_account = Twitter::REST::Client.new do |config|
          config.consumer_key        = "WBIuUgFwoOZNmWDk0FkveW9xi"
          config.consumer_secret     = "VxmRSeOZANjYMmP45Cy8mnIUwzb0cux7PvGI8biuTLGzoMDUUt"
          config.access_token        = "785500627703136257-LRMvMpJvNhTVVE0NmZIeOUBtKY0WC0Z"
          config.access_token_secret = "Q76Y8avuFt0Txi8WQF6sYszuQj7SvsBNGFKobeGbO9C1f"
        end

        client = TweetStream::Client.new

        client.track('sampletweetclt') do |status|

          msg = status.text
          tag = "#sampletweetclt"
          mention = "fuzzy"

          puts msg
          puts tag

          if msg.include? tag
            message = "@#{status.user.screen_name} Happy Holidays from @ellodigsby!"
            sleep 5
            @store_account.update(message,  in_reply_to_status_id: status.id)
          end

        @tracker = Mixpanel::Tracker.new("9ae4dc350f5c0a7ccf5a0cff913c4a4d")

        @tracker.track(status.id, 'Tweets Received', { 'Hashtag' => tag, 'Message' => msg })

          puts 'Your code ran'
        end

  end
end
