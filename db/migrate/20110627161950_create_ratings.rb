class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings, :force => true do |t|
      t.column :rating, :integer, :default => 0, :null => false
      t.column :rateable_id, :integer, :default => 0, :null => false
      t.column :rateable_type, :string, :default => "", :null => false
      t.column :user_ip, :string, :default => "0.0.0.0", :null => false
    end

    add_index :ratings, [:rateable_id, :rating]
  end

  def self.down
    drop_table :ratings
  end
end
