class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.integer :user_id
      t.integer :poll_id
      t.string :description
      t.integer :comptevotes

      t.timestamps null: false
    end
  end
end
