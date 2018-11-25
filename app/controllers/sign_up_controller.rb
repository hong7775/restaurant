class SignUpController < ApplicationController
  
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        CustomerMailer.welcome_email(@customer.id).deliver_now
        format.html { redirect_to login_path, notice: 'Sign up was successfully. Please sign in.' }
        format.json { render login_path, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def customer_params
      params.require(:customer).permit(:name, :email, :password)
    end
  
end
