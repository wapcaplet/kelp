require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "page_should_not_contain" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "does not exist" do
        page_should_not_contain "Wazzup world"
      end
    end

    context "Regexp" do
      it "does not match" do
        page_should_not_contain /(Foo|Bar|Baz) world/
      end
    end
  end

  context "fails when" do
    context "String" do
      it "exists" do
        lambda do
          page_should_not_contain "Hello world"
        end.should raise_error
        lambda do
          page_should_not_contain "Goodbye world"
        end.should raise_error
      end
    end
    context "Regexp" do
      it "matches" do
        lambda do
          page_should_not_contain /(Hello|Goodbye) world/
        end.should raise_error
        lambda do
          page_should_not_contain /\d\d\d-\d\d\d\d/
        end.should raise_error
      end
    end

    it "not a String or Regexp" do
      lambda do
        page_should_not_contain 123
      end.should raise_error
    end
  end

end


