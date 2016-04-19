class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :poll_id
      t.string :token
      t.string :clef
      t.boolean :used

      t.timestamps null: false
    end
  end
end
