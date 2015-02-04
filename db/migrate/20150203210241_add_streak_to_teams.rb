class AddStreakToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :streak, :string
  end
end
