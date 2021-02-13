class User < ApplicationRecord
    has_secure_password
    include Discard::Model
    
    
    validates :name, presence: true, length: {maximum: 20}
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true, length: {minimum: 6, maximum: 20}, on: :create
    validates :password, format: { with: /\A(?=.*?[a-z])[a-z\d]{6,20}+\z/ }, on: :create

    has_many :notes, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :likes
    has_many :comments

end
