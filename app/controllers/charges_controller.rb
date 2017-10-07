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

    # @stripe_btn_data = {
    #  key: "#{ Rails.configuration.stripe[:publishable_key] }",
    #  description: "Premium Membership - #{current_user.email}",
    #  amount: 1500
    # }
  end

  def create
    # Braintree Integration
    # In production, you would use the nonce that was passed through params: (Ex: params[:payment_method_nonce])
    nonce = 'fake-valid-nonce'
    amount = "15"

    # Search the Braintree vault to see if there is an exisitng customer matching the current_user email
    collection = Braintree::Customer.search do |search|
      search.email.is "#{current_user.email}"
    end

    my_customer = nil

    collection.each do |customer|
      my_customer = customer.email
    end

    # If there is not an exisiting customer, create a new customer in the vault along with a new transaction
    # Otherwise, create a new transaction for the existing customer customer
    if my_customer == nil
      my_customer = Braintree::Customer.create(
        email: current_user.email
      )

      result = Braintree::Transaction.sale(
        customer_id: my_customer.customer.id,
        amount: amount,
        payment_method_nonce: nonce,
        options: {
          submit_for_settlement: true
        }
      )
    else
      my_customer = Braintree::Customer.search do |search|
        search.email.is "#{my_customer}"
      end

      my_customer = Braintree::Customer.find(my_customer.ids.first)
      binding.pry

      result = Braintree::Transaction.sale(
        customer_id: my_customer.id,
        amount: amount,
        payment_method_nonce: nonce,
        options: {
          submit_for_settlement: true
        }
      )
    end

    if result.success? || result.transaction
      puts "Transaction successful!: #{result.transaction.id}"
      flash[:notice] = "Welcome to Premium! You can now enjoy creating private wikis!"
      current_user.update_attributes(role: 'premium')
      current_user.update_attributes(braintree_id: my_customer.id)
      # current_user.update_attributes(braintree_subscription: )
      redirect_to root_path
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      puts error_messages
      flash[:alert] = error_messages
      redirect_to new_charge_path
    end

  # Stripe Integration
  # customer = Stripe::Customer.create(
  #   email: current_user.email,
  #   card: params[:stripeToken]
  # )
  #
  # subscription = Stripe::Subscription.create(
  #   customer: customer.id,
  #   plan: 'premium'
  # )
  #
  # current_user.update_attributes(role: 'premium')
  # current_user.update_attributes(stripe_id: customer.id)
  # current_user.update_attributes(stripe_subscription: subscription.id)
  #
  # flash[:notice] = "Your payment was successfully submitted, #{current_user.email}. Welcome to premium!"
  # redirect_to wikis_path
  #
  # rescue Stripe::CardError => e
  #   flash[:alert] = e.message
  #   redirect_to new_charge_path
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
