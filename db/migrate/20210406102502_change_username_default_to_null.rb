class ChangeUsernameDefaultToNull < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :username, :string, :null => true
  end
end
