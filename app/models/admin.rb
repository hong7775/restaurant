class Admin < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 4 }, on: :create
end
