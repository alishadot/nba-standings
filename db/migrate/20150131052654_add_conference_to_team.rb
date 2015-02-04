class AddConferenceToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :conference, :string
  end
end
