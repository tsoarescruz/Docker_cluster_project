class SearchResult < ApplicationRecord
  has_paper_trail

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
      hash[:occurrence] = found.occurrence + 1
      found.update(hash)
    else
      self.create(hash)
    end
  end

  def self.generate_search_queries
    products = Product.all

    products.each do |product|
      tags = product.tags.pluck(:name).to_a
      tags_combination = (0..tags.size).flat_map{|size| tags.combination(size).to_a}.drop(1)

      tags_combination.each do |tag|
        GoogleSearcherJob.perform_later "#{product.name} #{tag.join(' ')}"
      end
    end
  end


  rails_admin do
    list do
      sort_by :relevance

      field :title
      field :link
      field :relevance
      field :occurrence
      field :from
      field :created_at
      field :updated_at
    end
  end
end
