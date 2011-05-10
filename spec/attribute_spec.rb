require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kelp::Attribute, "should_be_disabled" do
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
      end.should raise_error(Kelp::Unexpected)
    end

    it "element does not have the disabled attribute" do
      lambda do
        should_be_disabled "first_name"
      end.should raise_error(Kelp::Unexpected)
    end
  end
end


describe Kelp::Attribute, "should_be_enabled" do
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
      end.should raise_error(Kelp::Unexpected)
    end

    it "element has the disabled attribute" do
      lambda do
        should_be_enabled "readonly"
      end.should raise_error(Kelp::Unexpected)
    end
  end
end


