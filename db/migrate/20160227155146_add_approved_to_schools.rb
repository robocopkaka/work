class AddApprovedToSchools < ActiveRecord::Migration
  def change
  	change_column_default(:schools, :approved, false)
  end
end
