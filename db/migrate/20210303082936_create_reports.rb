class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.citext :content

      t.timestamps
    end
  end
end
