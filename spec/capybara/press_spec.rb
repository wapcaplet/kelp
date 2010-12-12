require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#press" do
  before(:each) do
    visit('/home')
  end

  context "should pass" do
    it "when the button exists" do
      press "Submit"
    end

    it "when the button exists within the scope" do
      press "Submit", :within => "#fields"
    end
  end

  context "should fail" do
    it "when the button does not exist" do
      lambda do
        press "Poke"
      end.should raise_error
    end

    it "when the button does not exist in the scope" do
      lambda do
        press "Submit", :within => "#greeting"
      end.should raise_error
    end
  end
end


