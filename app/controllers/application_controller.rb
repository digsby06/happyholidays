require 'tweetstream'
require 'twitter'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  system('tweetstreamer.rb')


end
