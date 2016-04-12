class CreatePolls < ActiveRecord::Migration
  def change
    drop_table :polls
    create_table :polls do |t|
      t.string :title
      t.integer :managerid
      t.string :description
      t.datetime :datestart
      t.datetime :datefinish
      t.datetime :datepublish
      t.integer :limitto

      t.timestamps null: false
    end
  end
end
