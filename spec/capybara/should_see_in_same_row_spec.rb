require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_see_in_same_row" do
  before(:each) do
    visit('/home')
  end

  context "should pass" do
    it "when two strings are in the same row" do
      should_see_in_same_row ["Eric", "Edit"]
      should_see_in_same_row ["John", "Edit"]
      should_see_in_same_row ["Terry", "Edit"]
    end

    it "when three strings are in the same row" do
      should_see_in_same_row ["Eric", "555-4444", "Edit"]
      should_see_in_same_row ["John", "666-5555", "Edit"]
      should_see_in_same_row ["Terry", "777-6666", "Edit"]
    end
  end
end

