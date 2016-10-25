require 'tweetstream'
require 'twitter'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  system('tweet_streamer.rb')


end
