class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :name
      t.date :date_of_birth
      t.string :gender
      t.string :religion
      t.string :address
      t.string :phone
      t.string :email
      t.string :office_name
      t.string :office_address
      t.string :office_phone
      t.string :job_title
      t.string :campus_name
      t.string :campus_address
      t.string :campus_phone

      t.timestamps
    end
  end
end
