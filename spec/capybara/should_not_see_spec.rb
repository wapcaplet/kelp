require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_not_see" do
  before(:each) do
    visit('/home')
  end

  context "with String" do
    context "should pass" do
      it "when the string does not exist" do
        should_not_see "Goodbye cruel world"
      end

      it "when the string exists but is not within the scope" do
        should_not_see "Goodbye world", :within => "#greeting"
      end
    end

    context "should fail" do
      it "when the string exists" do
        lambda do
          should_not_see "Hello world"
        end.should raise_error
      end

      it "when the string exists within the scope" do
        lambda do
          should_not_see "Hello world", :within => "#greeting"
        end.should raise_error
      end
    end

  end

  context "with Regexp" do
    context "should pass" do
      it "when the regexp does not match" do
        should_not_see /(Yo|Wazzup) world/
      end

      it "when the regexp matches but is not within the scope" do
        should_not_see /Goodbye world/, :within => "#greeting"
      end
    end

    context "should fail" do
      it "when the regexp exists" do
        lambda do
          should_not_see /(Hello|Goodbye) world/
        end.should raise_error
      end

      it "when the regexp is within the scope" do
        lambda do
          should_not_see /(Hello|Goodbye) world/, :within => "#greeting"
        end.should raise_error
      end
    end
  end
end


