require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_see_in_same_row" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "two strings are in the same row" do
      should_see_in_same_row ["Eric", "Edit"]
      should_see_in_same_row ["John", "Edit"]
      should_see_in_same_row ["Terry", "Edit"]
    end

    it "three strings are in the same row" do
      should_see_in_same_row ["Eric", "555-4444", "Edit"]
      should_see_in_same_row ["John", "666-5555", "Edit"]
      should_see_in_same_row ["Terry", "777-6666", "Edit"]
    end
  end
end

describe WebHelper, "#should_see_in_same_row" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "two strings are not in the same row" do
      should_not_see_in_same_row ["Eric", "Delete"]
      should_not_see_in_same_row ["John", "Delete"]
      should_not_see_in_same_row ["Terry", "Delete"]
    end

    it "any two of three strings are not in the same row" do
      should_not_see_in_same_row ["Eric", "555-4444", "Delete"]
      should_not_see_in_same_row ["John", "666-5555", "Delete"]
      should_not_see_in_same_row ["Terry", "777-6666", "Delete"]
    end
  end
end
