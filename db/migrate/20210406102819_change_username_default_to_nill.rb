class ChangeUsernameDefaultToNill < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :username, nil
  end
end
