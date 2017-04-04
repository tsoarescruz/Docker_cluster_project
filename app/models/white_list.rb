class WhiteList < ApplicationRecord
  has_paper_trail

  validates_presence_of :domain
  validates_uniqueness_of :domain
end
