class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :location
      t.string :website
      t.string :picture
      t.boolean :approved
      t.float :latitude
      t.float :longitude
      t.string :classification
      t.string :category

      t.timestamps null: false
    end
  end
end
