# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
                                  title: "Title",
                                  description: "Description",
                                  status: 2,
                                  user: nil
                                ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
