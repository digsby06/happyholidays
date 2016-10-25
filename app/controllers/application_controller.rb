require 'tweetstream'
require 'twitter'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  system('tweetstreamer.rb')


end
