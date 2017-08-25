class SearchResult < ApplicationRecord
  has_paper_trail

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

      #field :screenshot do
      # formatted_value do
      #   if not bindings[:object].screenshot.url(:thumb).include? 'missing.png'
      #      link_to(image_tag(bindings[:object].screenshot.url(:thumb)), bindings[:object].link, target: :blank)
      #    else
      #      'No image'
      #    end
      #  end
      #end

      field :link
      field :relevance
      field :occurrence
      field :from
      field :created_at
      field :updated_at
    end
  end
end
