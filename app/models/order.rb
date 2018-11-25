# == Schema Information
#
# Table name: orders
#
#  id            :bigint(8)        not null, primary key
#  ordering_date :date
#  customer_id   :bigint(8)
#  remark        :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  validates :customer, presence: true
  
  def total_amount
    total = 0.0
    order_items.each do |order_item|
      total += order_item.quantity * order_item.menu_item.unit_price
    end
    total
  end
  
  def testing
    Order.testing
    self.class.testing
    puts "instance method" 
    private_method
  end
  
  def self.testing
    puts "1st class method"
    testing1
  end
  
  def self.testing1
    puts "2nd class method"
    private_method
  end
  
  private
    def private_method
      puts "private_method"
    end
  
end
