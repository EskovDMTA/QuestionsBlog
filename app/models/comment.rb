class Comment < ApplicationRecord
  include Authorship
  
  validates :body, presence: true, length: {minimum: 2}
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
