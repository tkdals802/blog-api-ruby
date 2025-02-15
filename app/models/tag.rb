class Tag < ApplicationRecord
  has_and_belongs_to_many :articles
  # tag:article - n:m関係
end
