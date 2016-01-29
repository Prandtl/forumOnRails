class AddDefaultToUserstatus < ActiveRecord::Migration
  def change
    change_column_default :users, :userstatus, 0
  end
end
