require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kelp::Navigation, "follow" do
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
      end.should raise_error(Kelp::MissingLink)
    end

    it "link is not within the scope" do
      lambda do
        follow "About Us", :within => "#invalid_scope"
      end.should raise_error(Kelp::InvalidScope)
    end
  end

end


describe Kelp::Navigation, "press" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "button exists" do
      press "Submit message"
    end

    it "button exists within the scope" do
      press "Submit message", :within => "#fields"
    end
  end

  context "fails when" do
    it "button does not exist" do
      lambda do
        press "Poke"
      end.should raise_error(Kelp::MissingButton)
    end

    it "button exists but is not within the scope" do
      lambda do
        press "Submit message", :within => "#greeting"
      end.should raise_error(Kelp::MissingButton)
    end
  end
end


describe Kelp::Navigation, "click_link_in_row" do
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
      end.should raise_error(Kelp::MissingRow)
    end
  end
end


describe Kelp::Navigation, "should_be_on_page" do
  context "passes when" do
    it "current path matches the expected path" do
      visit('/home')
      should_be_on_page '/home'
      visit('/form')
      should_be_on_page '/form'
    end
  end

  context "fails when" do
    it "current path does not match the expected path" do
      visit('/home')
      lambda do
        should_be_on_page '/form'
      end.should raise_error(Kelp::Unexpected)
    end
  end
end


describe Kelp::Navigation, "should_have_query" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "actual and expected queries are empty" do
      empty_params = {}
      should_have_query empty_params
    end
  end

  context "fails when" do
    it "expected params when actual query is empty" do
      lambda do
        should_have_query :username => 'tony'
      end.should raise_error(Kelp::Unexpected)
    end
  end
end


