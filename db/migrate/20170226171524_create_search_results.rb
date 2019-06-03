class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :title
      t.text :link
      t.integer :status
      t.string :from
      t.integer :relevance, default: 0
      t.integer :occurrence, default: 1
      # t.attachment :screenshot

      t.timestamps
    end
  end
end
