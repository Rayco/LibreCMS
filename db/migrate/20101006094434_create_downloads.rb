class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.references :application
      t.integer :windows, :default => 0
      t.integer :linux, :default => 0
      t.integer :mac, :default => 0
      t.integer :multiplatform, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
