require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_be_enabled" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "element does not have the disabled attribute" do
      should_be_enabled "first_name"
    end
  end

  context "fails when" do
    it "element does not exist" do
      lambda do
        should_be_enabled "nonexistent"
      end.should raise_error
    end

    it "element has the disabled attribute" do
      lambda do
        should_be_enabled "readonly"
      end.should raise_error
    end
  end
end


