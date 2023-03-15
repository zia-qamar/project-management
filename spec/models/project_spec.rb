# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    subject { described_class.new }

    it "is valid with valid attributes" do
      user = User.create(email: "test@example.com", password: "password")
      subject.title = "Test project"
      subject.user = user
      expect(subject).to be_valid
    end
  end

  it "is not valid without a title" do
    expect(subject).to_not be_valid
    expect(subject.errors[:title]).to include("can't be blank")
  end

  it "is not valid with a non-unique title" do
    user = User.create(email: "test@example.com", password: "password")
    subject.title = "Test project"
    subject.user = user
    subject.save

    new_project = Project.new(title: "Test project", user: user)
    expect(new_project).to_not be_valid
    expect(new_project.errors[:title]).to include("has already been taken")
  end
end
