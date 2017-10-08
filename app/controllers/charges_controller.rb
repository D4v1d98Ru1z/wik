class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.premium?
      flash[:notice] = "You are already subscribed to premium!"
      redirect_to root_path
    elsif current_user.admin?
      flash[:notice] = "You are an admin and do not need to subscribe to premium!"
      redirect_to root_path
    end

    @token = Braintree::ClientToken.generate

  end

  def create
    # In production, you would use the nonce that was passed through params: (Ex: params[:payment_method_nonce])
    nonce = 'fake-valid-nonce'

    # Search the Braintree vault to see if there is an exisitng customer matching the current_user email
    customers = Braintree::Customer.search do |search|
      search.email.is "#{current_user.email}"
    end

    # If there is not an exisiting customer, create a new customer in the vault
    # and save their payment method from the nonce
    if customers.ids.empty?
      my_customer = Braintree::Customer.create(
        email: current_user.email,
        payment_method_nonce: nonce,
      )
      
      # Find the new customer that was newly created
      my_new_customer = Braintree::Customer.find(my_customer.customer.id)

      # assign the customer's payment method from the stored payment method token
      customer_payment_method = my_new_customer.payment_methods.first.token

    # Otherwise, assign the existing customer
    else
      my_customer = Braintree::Customer.find(customers.ids.first)
      customer_payment_method = Braintree::PaymentMethod.create(
        customer_id: my_customer.id,
        payment_method_nonce: nonce
      )
    end

    # create a new subscription
    customer_subscription = Braintree::Subscription.create(
      plan_id: "56q6",
      payment_method_token: customer_payment_method.payment_method.token,
    )

    # if the subscription is successful, update the role, braintree_id, and braintree_subscription attributes
    if customer_subscription.success?
      puts "Subscription successful!: #{customer_subscription.subscription.id}"
      flash[:notice] = "Welcome to Premium! You can now enjoy creating private wikis!"
      current_user.update_attributes(role: 'premium')
      current_user.update_attributes(braintree_id: my_customer.id)
      current_user.update_attributes(braintree_subscription: customer_subscription.subscription.id)
      redirect_to root_path
    # otherwise raise the error messages and redirect to the new charge path
    else
      error_messages = customer_subscription.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      puts error_messages
      flash[:alert] = error_messages
      redirect_to new_charge_path
    end
  end

  def destroy

    # Stripe Integration
    # subscription = Stripe::Subscription.retrieve(current_user.stripe_subscription)
    # subscription.delete
    # current_user.update_attributes(role: 'standard')
    # current_user.wikis.update_all(private: false)
    # redirect_to root_path
    # flash[:notice] = "Your membership has been downgraded to standard."
  end
end
