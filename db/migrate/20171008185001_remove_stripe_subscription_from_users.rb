class RemoveStripeSubscriptionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_subscription, :string
  end
end
