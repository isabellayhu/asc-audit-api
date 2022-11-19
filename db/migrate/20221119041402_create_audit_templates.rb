class CreateAuditTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_templates do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
