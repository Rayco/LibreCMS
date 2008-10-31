class RemoveUpdatedAtInAll < ActiveRecord::Migration
  def self.up
    remove_column :applications, :logo_updated_at
    remove_column :categories, :icon_updated_at
    remove_column :screenshots, :image_updated_at
  end

  def self.down
    add_column :applications, :logo_updated_at, :datetime
    add_column :categories, :icon_updated_at,   :datetime
    add_column :screenshots, :image_updated_at, :datetime
  end
end
