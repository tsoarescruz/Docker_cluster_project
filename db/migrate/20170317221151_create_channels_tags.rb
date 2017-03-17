class CreateChannelsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :channels_tags, id: false do |t|
      t.integer :channel_id
      t.integer :tag_id
    end
  end
end
