require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:wiki) { Wiki.create!(title: "Wiki", body: "Body", user: user) }
  let(:Collaborator) { Collaborator.create!(wiki: wiki, user: user) }

  it { is_expected.to belong_to(:wiki) }
  it { is_expected.to belong_to(:user) }
end
