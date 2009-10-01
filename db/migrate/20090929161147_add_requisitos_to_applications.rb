class AddRequisitosToApplications < ActiveRecord::Migration
  def self.up
    add_column :applications, :requisitos, :text
  end

  def self.down
    remove_column :applications, :requisitos
  end
end
