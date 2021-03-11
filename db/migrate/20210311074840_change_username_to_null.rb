class ChangeUsernameToNull < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :username, :string, default: nil
  end
end
