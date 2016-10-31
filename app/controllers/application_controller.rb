require 'tweetstream'
require 'twitter'
require 'mixpanel-ruby'
require 'rake'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

th = Thread.new do
  %x[bundle exec rake happyholidays:tweetstreamer]
end

thr = Thread.new {
      puts "thread"
      Event.timer
      puts "timer is running"
  }


end
