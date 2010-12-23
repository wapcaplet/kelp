require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "follow" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "link exists" do
      follow "About Us"
      should_see "We're a small company with an even smaller webpage"
    end

    it "link is within the scope" do
      follow "About Us", :within => "#links"
      should_see "We're a small company with an even smaller webpage"
    end
  end

  context "fails when" do
    it "link does not exist" do
      lambda do
        follow "About Them"
      end.should raise_error(Capybara::ElementNotFound)
    end

    it "link is not within the scope" do
      lambda do
        follow "About Us", :within => "#invalid_scope"
      end.should raise_error(Capybara::ElementNotFound)
    end
  end

end


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
      end.should raise_error(Capybara::ElementNotFound)
    end

    it "button exists but is not within the scope" do
      lambda do
        press "Submit", :within => "#greeting"
      end.should raise_error(Capybara::ElementNotFound)
    end
  end
end


describe "click_link_in_row" do
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
      end.should raise_error(Capybara::ElementNotFound)
    end
  end
end


