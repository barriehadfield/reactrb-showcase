class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :name
      t.integer :todo_id

      t.timestamps null: false
    end
  end
end
