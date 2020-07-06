class AddUserIdForeignKeyToNote < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :notes, :users, on_delete: :cascade
  end
end
