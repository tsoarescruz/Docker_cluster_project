class AddAttachmentScreenshotToSearchResults < ActiveRecord::Migration
  def self.up
    change_table :search_results do |t|
      t.attachment :screenshot, before: :created_at
    end
  end

  def self.down
    remove_attachment :search_results, :screenshot
  end
end
