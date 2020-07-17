class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birthdate
      t.string :gender
      t.text :address

      t.timestamps
    end
  end
end
