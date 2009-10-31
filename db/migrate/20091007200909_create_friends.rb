class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.string   :gamertag
      t.string   :tile_url
      t.integer  :gamerscore
      t.string   :status
      t.string   :profile_url
      t.string   :info
      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
