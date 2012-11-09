class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :content
      t.integer :historable_id
      t.string :historable_type
      t.integer :issue
      t.integer :page

      t.timestamps
    end
  end
end
