class CreateFileStores < ActiveRecord::Migration[5.2]
  def change
    create_table :file_stores do |t|
      t.references :fileable, polymorphic: true
      t.jsonb  :attachment_data
      t.string  :token, unique: true
      t.timestamps
    end
  end
end
