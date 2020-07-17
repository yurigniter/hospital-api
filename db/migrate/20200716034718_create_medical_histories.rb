class CreateMedicalHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_histories do |t|
      t.date :date
      t.text :details
      t.references :patient, foreign_key: true
      t.timestamps
    end
  end
end
