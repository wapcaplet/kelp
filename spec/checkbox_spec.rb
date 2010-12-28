require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kelp::Checkbox, "checkbox_should_be_checked" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "the checkbox is checked by default" do
      checkbox_should_be_checked "I like cheese"
    end

    it "the checkbox is checked programmatically" do
      check "I like salami"
      checkbox_should_be_checked "I like salami"
    end
  end

  context "fails when" do
    it "the checkbox is unchecked by default" do
      lambda do
        checkbox_should_be_checked "I like salami"
      end.should raise_error
    end

    it "the checkbox is unchecked programmatically" do
      uncheck "I like cheese"
      lambda do
        checkbox_should_be_checked "I like cheese"
      end.should raise_error
    end
  end

end


describe Kelp::Checkbox, "checkbox_should_not_be_checked" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "the checkbox is unchecked by default" do
      checkbox_should_not_be_checked "I like salami"
    end

    it "the checkbox is unchecked programmatically" do
      uncheck "I like cheese"
      checkbox_should_not_be_checked "I like cheese"
    end
  end

  context "fails when" do
    it "the checkbox is checked by default" do
      lambda do
        checkbox_should_not_be_checked "I like cheese"
      end.should raise_error
    end

    it "the checkbox is checked programmatically" do
      check "I like salami"
      lambda do
        checkbox_should_not_be_checked "I like salami"
      end.should raise_error
    end
  end

end

