class ChangePasswordRequireForUsers < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :users, :password_digest, true
  end
end
