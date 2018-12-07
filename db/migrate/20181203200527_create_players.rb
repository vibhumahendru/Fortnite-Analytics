class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|

      t.string :full_name
      t.string :username
      t.string :console_type
      t.string :email

      t.timestamps
    end
  end
end
