class Post < ApplicationRecord
    belongs_to :user

    has_many :photos, dependent: :destroy
    accepts_nested_attributes_for :photos

    has_many :likes, -> { order(created_at: :desc)}, dependent: :destroy
    has_many :comments, dependent: :destroy

    def liked_by(user)
        Like.find_by(user_id: user.id, post_id: id)
    end
end
