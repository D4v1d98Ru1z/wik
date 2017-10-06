class AddBraintreeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :braintree_id, :string
  end
end
