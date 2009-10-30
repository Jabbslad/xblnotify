class Friend < ActiveRecord::Base
  def self.find_online
    find(:all, :conditions => ["presence != 'Offline'"])
  end
end
