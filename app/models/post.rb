class Post < ApplicationRecord
  validates(:title, presence: true, length: { minimum: 5, maximum: 30 })
end
