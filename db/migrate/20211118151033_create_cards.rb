class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :player
      t.string :startingDeck

      t.timestamps
    end
  end
end
