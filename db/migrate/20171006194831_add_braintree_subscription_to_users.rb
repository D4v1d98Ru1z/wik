class AddBraintreeSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :braintree_subscription, :string
  end
end
