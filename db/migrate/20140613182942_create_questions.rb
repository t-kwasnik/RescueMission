class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :uid, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
