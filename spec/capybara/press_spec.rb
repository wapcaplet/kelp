require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "press" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "button exists" do
      press "Submit"
    end

    it "button exists within the scope" do
      press "Submit", :within => "#fields"
    end
  end

  context "fails when" do
    it "button does not exist" do
      lambda do
        press "Poke"
      end.should raise_error
    end

    it "button exists but is not within the scope" do
      lambda do
        press "Submit", :within => "#greeting"
      end.should raise_error
    end
  end
end


