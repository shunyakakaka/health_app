class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :before_weight
      t.string :after_weight
      
      t.timestamps
    end
  end
end
