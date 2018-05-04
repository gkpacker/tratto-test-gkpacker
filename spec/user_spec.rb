require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.create(name: "Roberto")
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.create
    expect(user).to_not be_valid
  end
end
