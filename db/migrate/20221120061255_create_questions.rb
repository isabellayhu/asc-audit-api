# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :description
      t.string :photo_url
      t.references :audit_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
