class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.integer :translation
      t.citext :from
      t.citext :to
      t.references :user, null: false, foreign_key: true
      t.string :language
      t.string :link

      t.timestamps
    end
    add_index :entries, :link, unique: true
  end
end
