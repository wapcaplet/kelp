require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#click_link_in_row" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "link exists in the row" do
      click_link_in_row "Edit", "Eric"
      should_see "You are editing record 1"
    end
  end

  context "fails when" do
    it "link does not exist in the row" do
      lambda do
        click_link_in_row "Frob", "Eric"
      end.should raise_error
    end
  end
end


