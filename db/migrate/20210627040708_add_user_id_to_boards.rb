class AddUserIdToBoards < ActiveRecord::Migration[6.1]
  def change
    add_reference :boards, :user, forign_key: true
  end
end
