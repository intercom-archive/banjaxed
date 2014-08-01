class AddUserIdToIncidentsAndComments < ActiveRecord::Migration
  def change
    add_reference :incidents, :user, index: true
    add_reference :comments, :user, index: true
  end
end
