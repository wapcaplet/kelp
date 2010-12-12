require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#should_not_see" do
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


