require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#follow" do
  before(:each) do
    visit('/home')
  end

  context "should pass" do
    it "when the link exists" do
      follow "About Us"
      should_see "We're a small company with an even smaller webpage"
    end

    it "when the link is within the scope" do
      follow "About Us", :within => "#links"
      should_see "We're a small company with an even smaller webpage"
    end
  end

  context "should fail" do
    it "when the link does not exist" do
      lambda do
        follow "About Them"
      end.should raise_error
    end

    it "when the link is not within the scope" do
      lambda do
        follow "About Us", :within => "#invalid_scope"
      end.should raise_error
    end
  end

end

