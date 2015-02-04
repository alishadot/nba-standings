class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team
      t.integer :played
      t.integer :won
      t.integer :lost

      t.timestamps null: false
    end
  end
end
