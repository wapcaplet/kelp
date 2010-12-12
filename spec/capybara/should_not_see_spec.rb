require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_not_see" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "does not exist" do
        should_not_see "Goodbye cruel world"
      end

      it "exists but is not within the scope" do
        should_not_see "Goodbye world", :within => "#greeting"
      end
    end

    context "Regexp" do
      it "does not match" do
        should_not_see /(Yo|Wazzup) world/
      end

      it "matches but is not within the scope" do
        should_not_see /Goodbye world/, :within => "#greeting"
      end
    end
  end


  context "fails when" do
    context "String" do
      it "exists" do
        lambda do
          should_not_see "Hello world"
        end.should raise_error
      end

      it "exists within the scope" do
        lambda do
          should_not_see "Hello world", :within => "#greeting"
        end.should raise_error
      end
    end

    context "Regexp" do
      it "matches" do
        lambda do
          should_not_see /(Hello|Goodbye) world/
        end.should raise_error
      end

      it "matches within the scope" do
        lambda do
          should_not_see /(Hello|Goodbye) world/, :within => "#greeting"
        end.should raise_error
      end
    end

  end
end


