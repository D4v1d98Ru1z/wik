require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "title", body: "body", private: false) }

  describe "attributes" do
    it "has title, body, and private attribues" do
      expect(wiki).to have_attributes(title: "title", body: "body", private: false)
    end
  end
end
