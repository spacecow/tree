class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :article_id
      t.integer :relative_id
      t.string :type

      t.timestamps
    end
  end
end
