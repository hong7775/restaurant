# == Schema Information
#
# Table name: menu_items
#
#  id          :bigint(8)        not null, primary key
#  name        :string(255)      not null
#  description :text(65535)
#  unit_price  :decimal(6, 2)    default(0.0)
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MenuItem < ApplicationRecord
  belongs_to :category
  has_many :order_items
  
  has_one_attached :photo
  
  validates :name, presence: true, uniqueness: true
  validates :unit_price, numericality: true
end
