class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :secondName
      t.string :surname
      t.date :hireDate
      t.string :position
      t.integer :companyId

      t.timestamps
    end
  end
end
