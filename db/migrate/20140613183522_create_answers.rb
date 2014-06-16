class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :uid, null: false
      t.integer :question_id, null: false
      t.text     :description, null: false
      t.boolean :is_favorite, default: false
      t.timestamps
    end
  end
end
