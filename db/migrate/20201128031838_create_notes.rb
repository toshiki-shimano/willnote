class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :name, null: false
      t.text :memo1
      t.text :memo2
      
      t.timestamps
    end
  end
end
