class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



def scrape_darksky

require "rubygems"
require "json"
require 'nokogiri'
require 'open-uri'


url = "https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/42.7925607,140.6145884"
doc = Nokogiri::HTML(open(url))
data = JSON.parse(doc)
@today = (data["daily"]["data"][0]["precipAccumulation"]).round(1)
@tomorrow = (data["daily"]["data"][1]["precipAccumulation"]).round(1)
#three_day = data["daily"]["data"][0]["precipAccumulation"] + data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] 
@three_day = (data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"]).round(1) 
#seven_day = data["daily"]["data"][0]["precipAccumulation"] + data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"] + data["daily"]["data"][4]["precipAccumulation"] + data["daily"]["data"][5]["precipAccumulation"] + data["daily"]["data"][6]["precipAccumulation"]
@seven_day = (data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"] + data["daily"]["data"][4]["precipAccumulation"] + data["daily"]["data"][5]["precipAccumulation"] + data["daily"]["data"][6]["precipAccumulation"] + data["daily"]["data"][7]["precipAccumulation"]).round(1)


render template: 'scrape_darksky'

end




end



