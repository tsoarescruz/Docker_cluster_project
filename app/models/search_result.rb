class SearchResult < ApplicationRecord
  TITLE_SIMILARITY_THRESHOLD = 0.9

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
