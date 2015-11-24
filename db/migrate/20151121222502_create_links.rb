class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :category, index: true, foreign_key: true
      t.string :url
      t.references :user, index: true, foreign_key: true
    end
  end
end
