require 'pp'
require 'xboxlive'

namespace :xbl do
  desc "Update xbl statuses"
  task :update => :environment do
    xbl = XboxLive.new
    puts "Logging into Xbox Live"
    xbl.login('', '')
    puts "Fetching friends from Xbox Live"
    friends = xbl.friends
    friends.keys.each do |gamertag|
      if(user = User.find_by_gamertag(gamertag))
        user.gamerscore = friends[gamertag][:gamerscore]
        user.presence = friends[gamertag][:presence]
        user.description = friends[gamertag][:description]
        if user.changed?
          pp "Updating #{gamertag}"
          pp user.changes
          Notifier.deliver_status_notification("xbl: #{user.gamertag}: #{user.presence}") if user.presence_changed?
        end
        user.save!
      else
        puts "Adding '#{gamertag}'"
        User.create(friends[gamertag]) do |user|
          user.gamertag = gamertag
        end
      end
    end
  end
  
  desc "List statuses"
  task :list => :environment do
    puts "Listing Xbox Live statuses"
    User.find(:all).each do |user|
      pp user
    end
  end
end