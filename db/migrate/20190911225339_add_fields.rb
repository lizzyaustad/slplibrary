class AddFields < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string   :title, null: false
      t.string   :author, null: false
      t.string   :description
      t.integer  :quantity, null: false, default: 1
      t.string   :lent_by, null: false
      t.string   :borrowed_by, null: false
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :users do |t|
      t.string   :email
      t.string   :first_name
      t.string   :last_name
    end
  end
end
