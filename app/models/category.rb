class Category < ApplicationRecord
  has_many :articles
  # article:category - 1:1関係
end
