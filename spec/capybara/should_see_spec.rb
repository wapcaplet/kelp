require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_see" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "exists" do
        should_see "Hello world"
        should_see "Goodbye world"
      end

      it "multiple exist" do
        should_see [
          "Hello world",
          "Goodbye world"
        ]
      end

      it "is within the scope" do
        should_see "Hello world", :within => "#greeting"
      end
    end

    context "Regexp" do
      it "matches" do
        should_see /(Hello|Goodbye) world/
      end

      it "matches within the scope" do
        should_see /(Hello|Goodbye) world/, :within => "#greeting"
        should_see /(Hello|Goodbye) world/, :within => "#farewell"
      end
    end
  end

  context "fails when" do
    context "String" do
      it "does not exist" do
        lambda do
          should_see "Goodbye cruel world"
        end.should raise_error
      end

      it "any of several do not exist" do
        lambda do
          should_see [
            "Hello world",
            "Goodbye world",
            "Hello, nurse!"
          ]
        end.should raise_error
      end

      it "is not within the scope" do
        lambda do
          should_see "Goodbye world", :within => "#greeting"
        end.should raise_error
      end
    end

    context "Regexp" do
      it "does not match" do
        lambda do
          should_see /(Yo|Wazzup) world/
        end.should raise_error
      end

      it "matches but is not within the scope" do
        lambda do
          should_see /Goodbye world/, :within => "#greeting"
        end.should raise_error
      end
    end
  end

end

