class Tag < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :products

  validates_presence_of :name
end
