class AddVoteToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :vote_up, :integer, :default => 0
    add_column :applications, :vote_down, :integer, :default => 0
  end

  def self.down
    remove_column :applications, :vote_down
    remove_column :applications, :vote_up
  end
end
