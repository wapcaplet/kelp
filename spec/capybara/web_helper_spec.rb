require File.expand_path(File.dirname(__FILE__) + '/../../lib/capybara/web_helper')
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper do
  describe "#should_see" do
    before(:each) do
      visit('/home')
    end

    context "with String" do
      it "passes when the string exists" do
        should_see "Hello world"
        should_see "Goodbye world"
      end

      it "passes when the string is within the scope" do
        should_see "Hello world", :within => "#greeting"
      end

      it "passes when the string is after another string" do
        should_see "Second", :after => "First"
        should_see "Third", :after => "Second"
        should_see "Third", :after => "First"
      end

      it "passes when the string is before another string" do
        should_see "First", :before => "Second"
        should_see "Second", :before => "Third"
        should_see "First", :before => "Third"
      end

      it "fails when the string does not exist" do
        lambda do
          should_see "Goodbye cruel world"
        end.should raise_error
      end

      it "fails when the string is not within the scope" do
        lambda do
          should_see "Goodbye world", :within => "#greeting"
        end.should raise_error
      end
    end

    context "with Regexp" do
      it "passes when the regexp exists" do
        should_see /(Hello|Goodbye) world/
      end

      it "passes when the regexp is within the scope" do
        should_see /(Hello|Goodbye) world/, :within => "#greeting"
        should_see /(Hello|Goodbye) world/, :within => "#farewell"
      end

      it "fails when the regexp does not exist" do
        lambda do
          should_see /(Yo|Wazzup) world/
        end.should raise_error
      end

      it "fails when the regexp is not within the scope" do
        lambda do
          should_see /Goodbye world/, :within => "#greeting"
        end.should raise_error
      end
    end
  end

  describe "#should_not_see" do
    before(:each) do
      visit('/home')
    end

    context "with String" do
      it "fails when the string exists" do
        lambda do
          should_not_see "Hello world"
        end.should raise_error
      end

      it "fails when the string is within the scope" do
        lambda do
          should_not_see "Hello world", :within => "#greeting"
        end.should raise_error
      end

      it "passes when the string does not exist" do
        should_not_see "Goodbye cruel world"
      end

      it "passes when the string is not within the scope" do
        should_not_see "Goodbye world", :within => "#greeting"
      end
    end

    context "with Regexp" do
      it "fails when the regexp exists" do
        lambda do
          should_not_see /(Hello|Goodbye) world/
        end.should raise_error
      end

      it "fails when the regexp is within the scope" do
        lambda do
          should_not_see /(Hello|Goodbye) world/, :within => "#greeting"
        end.should raise_error
      end

      it "passes when the regexp does not exist" do
        should_not_see /(Yo|Wazzup) world/
      end

      it "passes when the regexp is not within the scope" do
        should_not_see /Goodbye world/, :within => "#greeting"
      end
    end
  end

  describe "#follow" do
    it "passes when the link exists" do
    end

    it "fails when the link does not exist" do
    end
  end

  describe "#press" do
    it "passes when the button exists" do
    end

    it "fails when the button does not exist" do
    end
  end
end

