class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :user_id
      t.string :description
      t.datetime :datestart
      t.datetime :datefinish
      t.datetime :datepublish
      t.integer :limitto

      t.timestamps null: false
    end
  end
end
