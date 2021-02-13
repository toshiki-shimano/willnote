class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :user_id, uniqueness: { scope: :post_id }
    validates :comment, presence: true, length: {maximum: 20 }
end
