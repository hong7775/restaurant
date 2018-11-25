class Api::MenuItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
      if session[:order_id].present?
        
      else
        render json: []
      end
      
    end
end