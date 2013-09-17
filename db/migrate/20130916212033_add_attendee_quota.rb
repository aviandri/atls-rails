class AddAttendeeQuota < ActiveRecord::Migration
  def up
  	add_column :training_schedules, :quota, :integer
  end

  def down
  end
end
