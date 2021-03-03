class ChangeEntriesToCitext < ActiveRecord::Migration[6.1]
  def change
    change_column :entries, :from, :citext
    change_column :entries, :to, :citext
  end
end
