class AddUserToNodes < ActiveRecord::Migration[5.2]
  def change
    add_reference :nodes, :user, foreign_key: true
  end
end
