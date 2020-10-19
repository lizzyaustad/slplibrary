class AddRequestStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :string, default: 'pending'
  end
end
