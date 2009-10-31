require 'pp'
Dir.entries("#{RAILS_ROOT}/lib").sort.each do |entry|
  if entry =~ /.jar$/
    require entry
  end
end

namespace :xbl do
  desc "Update xbl statuses"
  task :update => :environment do
    session = Java::xbl::Session.new
    puts "Logging into Xbox Live as '#{ENV['xbluser']}'"
    session.signIn(ENV['xbluser'], ENV['xblpass'])
    puts "Fetching friends from Xbox Live"
    friends = session.getFriends
    0.upto(friends.size-1) do |n|
      friend = friends.get(n)
      gamertag = friend.getGamerTag
      if (existing = Friend.find_or_create_by_gamertag(gamertag))
        existing.tile_url = friend.getTileURL
        existing.gamerscore = friend.getGamerScore      
        existing.status = friend.getStatus
        existing.profile_url = friend.getProfileURL
        existing.info = friend.getInfo
        if existing.changed?
          pp "Updating #{gamertag}"
          pp existing.changes
        end
        existing.save!
      end
    end
  end
  
  desc "List statuses"
  task :list => :environment do
    puts "Listing Xbox Live statuses"
    Friend.find(:all).each do |friend|
      pp friend
    end
  end
  
  desc "List online statuses"
  task :listonline => :environment do
    puts "Listing online Xbox Live statuses"
    Friend.find_online.each do |friend|
      pp friend
    end
  end
end