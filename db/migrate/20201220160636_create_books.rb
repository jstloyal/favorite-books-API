class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :author
      t.string :ratings
      t.string :genre

      t.timestamps
    end
  end
end
