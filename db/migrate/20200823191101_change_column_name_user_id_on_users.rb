class ChangeColumnNameUserIdOnUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_id, :oauth_id
  end
end
