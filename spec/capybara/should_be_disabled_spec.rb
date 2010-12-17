require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "should_be_disabled" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "element has the disabled attribute" do
      should_be_disabled "readonly"
    end
  end

  context "fails when" do
    it "element does not exist" do
      lambda do
        should_be_disabled "nonexistent"
      end.should raise_error
    end

    it "element does not have the disabled attribute" do
      lambda do
        should_be_disabled "first_name"
      end.should raise_error
    end
  end
end

