class AddCachedVotesToEntries < ActiveRecord::Migration[6.1]
  def change
    change_table :entries do |t|
      t.integer :cached_scoped_vote_votes_up, default: 0
      t.integer :cached_scoped_vote_votes_down, default: 0
      t.integer :cached_scoped_saved_votes_up, default: 0
      t.integer :cached_scoped_verify_votes_up, default: 0

      Entry.find_each(&:update_cached_votes)
    end
  end
end
