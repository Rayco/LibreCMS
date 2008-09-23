class CreateScreenshots < ActiveRecord::Migration
  def self.up
    create_table :screenshots do |t|
      t.references :application
      t.string :name
      t.string :shot_file_name
      t.string :shot_content_type
      t.integer :shot_file_size
      t.datetime :shot_updated_at
      t.integer :view
      t.timestamps
    end
  end
  
  def self.down
    drop_table :screenshots
  end
end
