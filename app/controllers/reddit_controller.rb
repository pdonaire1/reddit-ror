require 'httparty'
require 'will_paginate/array'
REDDIT_URL = "https://www.reddit.com/r/"
class RedditController < ApplicationController
  before_action :pagination_params

  def top
    response = HTTParty.get(REDDIT_URL + "all/.json?count=25", {
      "headers": {
        "User-Agent" => 'reddit-app:v0.0.(by/u/pablo_donaire29)'
      }
    })
    begin
      limit = pagination_params[:limit] ? pagination_params[:limit] : 50
      page = pagination_params[:page] ? pagination_params[:page] : 1
      json = JSON.parse(response.body)
      data = json["data"]["children"]
      paged = data.paginate(:page => page, :per_page => limit)
    rescue
      paged = response.body
    end
    render :json => paged
  end

  private
  def pagination_params
    params.permit(:limit, :page)
  end
end
