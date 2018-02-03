class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



def scrape_darksky

require "rubygems"
require "json"
require 'nokogiri'
require 'open-uri'




resorts = {
  
  :Niseko => [42.7925607,140.6145884],
  :Rusutsu => [42.720765,140.8246208],
  :Furano => [43.2788929,142.3346243],
  :Kiroro => [43.1015532,143.5976088],
  
  :Hakuba => [36.6908076,137.7758388],
  :Nozawa_Onsen => [36.9332568,138.4344672],
  :Shiga_Kogen => [36.7052466,138.5058287],
  :Myoko_Kogen => [36.892743,138.1740073],
  
  :YongPyong => [37.6429587,128.6781007],
  :Alpensia => [37.6542186,128.6695522],
  :Phoenix_Snow_Park => [37.5812246,128.3251215],
  :High1_Resort => [37.2049058,128.8375798],
  :Vivaldi_Park => [37.648144,127.6819313],
  
  :Yabuli => [44.780865,128.4454603],
  :Beidahu => [43.422146,126.6160153], #took ski field
  :Changbaishan => [41.7446585,127.6853884],
  :Chongli => [41.0354696,114.9045811]
  
  
  }

# This works resorts[:Niseko]





resorts.each { |resort, coords|  instance_variable_set("@#{resort}" + "_url", "https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/" + coords[0].to_s + "," + coords[1].to_s)  }     









# niseko
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














############## EVERYTHING BELOW HERE IS WORKING - CAN BE DELETED

# works
list = ["test1","test2","test3"] 

list.each { |t| instance_variable_set("@#{t}_var".to_sym, t) }
#



##### DWD - WORKS
for each in resorts 
puts each[0]
end




######


# DOESN'T WORK
for each in resorts

"#{each[0]}" + "_url" = "https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/" + each[1].to_s + "," + each[2].to_s

end

######



#### ALso doesn't work
resorts.each do |resort, coords| 

	"#{resort}" + "_url" = "https://api.darksky.net/forecast/979b169b4243ddb0a2ea22801e966bd0/" + coords[0].to_s + "," + coords[1].to_s

end 

############## 



