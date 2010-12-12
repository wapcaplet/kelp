require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_see" do
  before(:each) do
    visit('/home')
  end

  context "with String" do
    context "should pass" do
      it "when a string exists" do
        should_see "Hello world"
        should_see "Goodbye world"
      end

      it "when multiple strings exist" do
        should_see [
          "Hello world",
          "Goodbye world"
        ]
      end

      it "when a string is within the scope" do
        should_see "Hello world", :within => "#greeting"
      end
    end

    context "should fail" do
      it "when a string does not exist" do
        lambda do
          should_see "Goodbye cruel world"
        end.should raise_error
      end

      it "when any of several strings do not exist" do
        lambda do
          should_see [
            "Hello world",
            "Goodbye world",
            "Hello, nurse!"
          ]
        end.should raise_error
      end

      it "when the string is not within the scope" do
        lambda do
          should_see "Goodbye world", :within => "#greeting"
        end.should raise_error
      end
    end

  end

  context "with Regexp" do
    context "should pass" do
      it "when the regexp matches" do
        should_see /(Hello|Goodbye) world/
      end

      it "when the regexp matches within the scope" do
        should_see /(Hello|Goodbye) world/, :within => "#greeting"
        should_see /(Hello|Goodbye) world/, :within => "#farewell"
      end
    end

    context "should fail" do
      it "when the regexp does not match" do
        lambda do
          should_see /(Yo|Wazzup) world/
        end.should raise_error
      end

      it "when the regexp matches but is not within the scope" do
        lambda do
          should_see /Goodbye world/, :within => "#greeting"
        end.should raise_error
      end
    end
  end
end

