class AddCachedCountsToReferences < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :reports_count, :integer, default: 0
    add_column :users, :entries_count, :integer, default: 0
  end
end
