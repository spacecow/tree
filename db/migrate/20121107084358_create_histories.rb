class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :content
      t.integer :relation_id
      t.integer :issue
      t.integer :page

      t.timestamps
    end
  end
end
