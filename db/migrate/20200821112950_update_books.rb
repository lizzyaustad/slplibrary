class UpdateBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :borrowed_by, :checked_out_by
    change_column_null :books, :checked_out_by, true
    add_column :books, :isbn, :string
    add_column :books, :thumbnail, :string
  end
end
