class CreateWhiteLists < ActiveRecord::Migration[5.0]
  def change
    create_table :white_lists do |t|
      t.string :domain

      t.timestamps
    end
  end
end
