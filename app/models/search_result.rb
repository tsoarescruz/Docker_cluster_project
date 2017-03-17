class SearchResult < ApplicationRecord
  has_attached_file :screenshot, styles: {thumb: "100x100#", medium: "570>"}
  validates_attachment_content_type :screenshot, content_type: ["image/jpg", "image/jpeg"]

  def to_label
    URI.parse(self.link).host
  end

  def self.find_or_create hash
    begin
      uri_link = URI.parse(hash[:link])
    rescue Exception => e
      uri_link = URI.parse(hash[:link].split('/')[2])
    end

    found = self.where(['link LIKE ?', "%#{uri_link.host}%"]).first

    if found
      found.update(hash)
    else
      self.create(hash)
    end
  end

  def self.generate_search_queries
    channels = Channel.all

    channels.each do |channel|
      tags = channel.tags.pluck(:name).to_a
      tags_combination = (0..tags.size).flat_map{|size| tags.combination(size).to_a}.drop(1)

      tags_combination.each do |tag|
        GoogleSearcherJob.perform_later "#{channel.name} #{tag.join(' ')}"
      end
    end
  end
end
