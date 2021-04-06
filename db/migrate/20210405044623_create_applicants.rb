class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :status, default: 'In Progress'
      t.string :personal_statement

      t.timestamps
    end
  end
end
