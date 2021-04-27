class AddCompetitionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :competition, :integer, default: 0
  end
end
