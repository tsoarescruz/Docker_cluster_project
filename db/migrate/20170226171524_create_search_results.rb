class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :title
      t.text :link
      t.integer :status
      t.string :from

      t.timestamps
    end
  end
end
