class AddColumnUserNumToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :user_num, :string
  end
end
