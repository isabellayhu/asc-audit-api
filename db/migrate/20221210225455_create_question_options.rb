class CreateQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :question_options do |t|
      t.integer :position, null: false
      t.string :description, null: false
      t.boolean :grade, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end

    add_index :question_options, [:position, :question_id], unique: true
  end
end
