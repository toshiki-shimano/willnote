class AddUserIdToNotes < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM notes;'
    add_reference :notes, :user, null: false, index: true
  end
  
  def down
    remove_reference :notes, :user, index: true
  end
end
