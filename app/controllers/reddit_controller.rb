require 'httparty'
REDDIT_URL = "https://www.reddit.com/r/"
class RedditController < ApplicationController
  def top
    response = HTTParty.get(REDDIT_URL + "all/.json?count=50")
    render :json => response.body
  end
end
