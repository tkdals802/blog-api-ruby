class AddUserArticleCascade < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :articles, :users

    add_foreign_key :articles, :users, ondelete: :cascade
  end
end
