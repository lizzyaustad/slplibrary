class AddRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string   :requested_by, null: false
      t.string   :book_id, null: false
      t.integer  :times_renewed, null: false, default: 0
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :books, :available, :integer
  end
end
