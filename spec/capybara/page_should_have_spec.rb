require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#page_should_have" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "exists" do
        page_should_have "Hello world"
        page_should_have "Goodbye world"
      end
    end
    context "Regexp" do
      it "matches" do
        page_should_have /(Hello|Goodbye) world/
        page_should_have /\d\d\d-\d\d\d\d/
      end
    end
  end

  context "fails when" do
    context "String" do
      it "does not exist" do
        lambda do
          page_should_have "Wazzup world"
        end.should raise_error
      end
    end

    context "Regexp" do
      it "does not match" do
        lambda do
          page_should_have /(Foo|Bar|Baz) world/
        end.should raise_error
      end
    end

    it "not a String or Regexp" do
      lambda do
        page_should_have 123
      end.should raise_error
    end
  end

end

