class CreateVolunteers < ActiveRecord::Migration[7.0]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end
