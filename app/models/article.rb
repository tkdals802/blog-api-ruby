class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags
  # user:article - 1:n関係
  # category:article - 1:1関係
  # tag:article - n:m関係
end
