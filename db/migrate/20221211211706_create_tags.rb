class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    create_join_table :applicants, :tags
  end
end
