class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.text :json_data 
      t.string :url
      t.string :filename
      t.references :applicant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
