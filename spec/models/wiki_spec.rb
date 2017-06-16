require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: "user@user.com", password: "password") }
  let(:wiki) { Wiki.create!(title: "title", body: "body", private: false, user: user) }

  describe "attributes" do
    it "has title, body, and private attribues" do
      expect(wiki).to have_attributes(title: "title", body: "body", private: false, user: user)
    end
  end
end
