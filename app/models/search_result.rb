class SearchResult < ApplicationRecord
  has_attached_file :screenshot, styles: {thumb: "100x100#", medium: "570>"}
  validates_attachment_content_type :screenshot, content_type: ["image/jpg", "image/jpeg"]

  def to_label
    self.link.rpartition('/').first
  end

  def self.find_or_create hash
    link_domain = hash[:link].rpartition('/').first
    found = self.where(['link LIKE ?', "#{link_domain}%"]).first

    if found
      found.update(hash)
    else
      self.create(hash)
    end
  end

  def self.froms
    ['Google']
  end
end
