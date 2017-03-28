class WhiteList < ApplicationRecord
    validates_presence_of :domain
    validates_uniqueness_of :domain
end
