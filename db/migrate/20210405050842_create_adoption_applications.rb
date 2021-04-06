class CreateAdoptionApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :adoption_applications do |t|
      t.references :applicant, foreign_key: true
      t.references :pet, foreign_key: true
    end
  end
end