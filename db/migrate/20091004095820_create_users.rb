class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :gamertag
      t.integer  :gamerscore
      t.string   :presence
      t.string   :description
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
