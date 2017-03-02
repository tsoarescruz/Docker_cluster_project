require 'uri'

class SearchResult < ApplicationRecord
  has_attached_file :screenshot, styles: {thumb: "100x100#", medium: "570>"}
  validates_attachment_content_type :screenshot, content_type: ["image/jpg", "image/jpeg"]

  def to_label
    URI.parse(self.link)
  end

  def self.find_or_create hash
    uri_link = URI.parse(hash[:link])

    found = self.where(['link LIKE ?', "%#{uri_link.host}%"]).first

    if found
      found.update(hash)
    else
      self.create(hash)
    end
  end

  def self.generate_search_queries
    channels = Channel.all.pluck(:name)
    tags = Tag.all.pluck(:name)
    tags_combination = (0..tags.size).flat_map{|size| tags.combination(size).to_a}.drop(1)
    queries = []

    channels.each do |channel|
      tags_combination.each do |tag|
        GoogleSearcherJob.perform_later "#{channel} #{tag.join(' ')}"
      end
    end
  end

  def self.froms
    ['Google']
  end
end
