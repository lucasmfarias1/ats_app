class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :summary
      t.string :photo_url
      t.integer :rating
      t.string :phone
      t.string :email
      t.string :website
      t.string :location

      t.timestamps
    end
  end
end
