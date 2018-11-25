class OrderEngine
    
    def self.order(order_id, user_id, menu_item_id, quantity)
        order = find_or_create_order(order_id, user_id)
        order_item = order.order_items.find_by(menu_item_id: menu_item_id)
        order_item = update_or_create_order_item(order_item, order, quantity, menu_item_id)
        return order.id, order_item.menu_item.name
    end
    
    def self.find_or_create_order(order_id, user_id)
      user = Customer.find user_id 
      
      if order_id.present?
         order = user.orders.find order_id
      else 
         order = Order.new(customer_id: user_id)
         order.ordering_date = Date.today
         order.save
      end
      order
    end
    
    def self.update_or_create_order_item(order_item, order, quantity, menu_id)
      
      if order_item.present?
         order_item.quantity += quantity.to_i
      else
         order_item = order.order_items.new
         order_item.menu_item_id =  menu_id
         order_item.quantity = quantity
      end
      order_item.save
      return order_item
    end 
end