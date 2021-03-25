class RemovePositionFromNotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :notes, :position, :integer
  end
end
