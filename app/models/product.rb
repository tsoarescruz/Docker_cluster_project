class Product < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :tags

  validates_presence_of :name

  rails_admin do
    list do
      field :name
      field :tags
      field :created_at
      field :updated_at
    end
  end
end
