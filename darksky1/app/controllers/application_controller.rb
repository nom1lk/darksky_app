class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



def scrape_darksky

require "rubygems"
require "json"
require 'nokogiri'
require 'open-uri'




resorts = {
  
  :Niseko => [42.864462,140.701598],
  :Rusutsu => [42.739169,140.910508],
  :Furano => [43.329196,142.337712],
  :Kiroro => [43.075914,140.982185],
  
  :Hakuba => [36.702350,137.832192],
  :Nozawa_Onsen => [36.920301,138.451982],
  :Shiga_Kogen => [36.767651,138.514797],
  :Myoko_Kogen => [36.887204,138.177576],
  
  :YongPyong => [37.643422,128.680311],
  :Alpensia => [37.654394,128.671719],
  :Phoenix_Snow_Park => [37.574514,128.322196],
  :High1_Resort => [37.205229,128.839780],
  :Vivaldi_Park => [37.643741,127.683793],
  
  :Yabuli => [44.781119,128.447592],
  :Beidahu => [43.471269,126.493526], #took ski field
  :Changbaishan => [42.102153,127.505355],
  :Chongli => [40.975317,115.282733]
  
  # Uncomment below to test melbourne (no precipAccumulation in JSON) 
  # for potential issues when precipAccumulation is not present in JSON
  # https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/-37.8136,144.9631
  #,:Melbourne => [-37.8136,144.9631]
  # No issues in controller -> @Melbourne and @Melbourne_today return Nil
  # Assuming no issues in view

  
  }

# This works resorts[:Niseko]




# this generates urls programmatically and stores them as instance variables e.g. @Niseko_url (note the upper case first letter - exact same as symbols in resorts hash)
resorts.each { |resort, coords|  instance_variable_set("@#{resort}" + "_url", 
	"https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/" + 
	coords[0].to_s + "," + coords[1].to_s)  }     


# takes around 20 seconds - ouch
resorts.each { |resort, coords|  instance_variable_set("@#{resort}" + "_data", JSON.parse(Nokogiri::HTML(open(instance_variable_get("@#{resort}" + "_url"))))) } 


# create final instance variables for the view
# Currently returns "cannot coerce Nil to float error" # .to_f.round(1)
resorts.each { |resort, coords|  
	instance_variable_set("@#{resort}" + "_today", ((instance_variable_get("@#{resort}" + "_data")["daily"]["data"][0]["precipAccumulation"].to_f * 2.54).round(1)) ) 
    instance_variable_set("@#{resort}" + "_tomorrow",   ((instance_variable_get("@#{resort}" + "_data")["daily"]["data"][1]["precipAccumulation"].to_f * 2.54).round(1) )) 
    instance_variable_set("@#{resort}" + "_three_day",   ((instance_variable_get("@#{resort}" + "_data")["daily"]["data"][1]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][2]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][3]["precipAccumulation"].to_f) * 2.54).round(1)) 
    instance_variable_set("@#{resort}" + "_seven_day",   ((instance_variable_get("@#{resort}" + "_data")["daily"]["data"][1]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][2]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][3]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][4]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][5]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][6]["precipAccumulation"].to_f + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][7]["precipAccumulation"].to_f) * 2.54).round(1) ) 
} 




# resorts.each { |resort, coords|  
    
#     instance_variable_set("@#{resort}" + "_three_day",   (instance_variable_get("@#{resort}" + "_data")["daily"]["data"][1]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][2]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][3]["precipAccumulation"])) 
#     #instance_variable_set("@#{resort}" + "_seven_day",   (instance_variable_get("@#{resort}" + "_data")["daily"]["data"][1]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][2]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][3]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][4]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][5]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][6]["precipAccumulation"] + instance_variable_get("@#{resort}" + "_data")["daily"]["data"][7]["precipAccumulation"]) ) 
# } 




render template: 'scrape_darksky'

end




end









# A bit about instance_variable_get:
# From here: https://stackoverflow.com/questions/30840127/get-value-from-string-representing-local-variable
# eval("@Niseko_url")
# instance_variable_get("@Niseko_url")
# binding.local_variable_get("variable") - doesn't work here since we're dealing with an instance variable, not a local one






# ORIGINAL 
# url = "https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/42.7925607,140.6145884"
# doc = Nokogiri::HTML(open(url))
# data = JSON.parse(doc)
# @today = (data["daily"]["data"][0]["precipAccumulation"]).round(1)
# @tomorrow = (data["daily"]["data"][1]["precipAccumulation"]).round(1)
# #three_day = data["daily"]["data"][0]["precipAccumulation"] + data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] 
# @three_day = (data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"]).round(1) 
# #seven_day = data["daily"]["data"][0]["precipAccumulation"] + data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"] + data["daily"]["data"][4]["precipAccumulation"] + data["daily"]["data"][5]["precipAccumulation"] + data["daily"]["data"][6]["precipAccumulation"]
# @seven_day = (data["daily"]["data"][1]["precipAccumulation"] + data["daily"]["data"][2]["precipAccumulation"] + data["daily"]["data"][3]["precipAccumulation"] + data["daily"]["data"][4]["precipAccumulation"] + data["daily"]["data"][5]["precipAccumulation"] + data["daily"]["data"][6]["precipAccumulation"] + data["daily"]["data"][7]["precipAccumulation"]).round(1)





