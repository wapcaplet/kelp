require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe WebHelper, "#page_should_not_have" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "does not exist" do
        page_should_not_have "Wazzup world"
      end
    end

    context "Regexp" do
      it "does not match" do
        page_should_not_have /(Foo|Bar|Baz) world/
      end
    end
  end

  context "fails when" do
    context "String" do
      it "exists" do
        lambda do
          page_should_not_have "Hello world"
        end.should raise_error
        lambda do
          page_should_not_have "Goodbye world"
        end.should raise_error
      end
    end
    context "Regexp" do
      it "matches" do
        lambda do
          page_should_not_have /(Hello|Goodbye) world/
        end.should raise_error
        lambda do
          page_should_not_have /\d\d\d-\d\d\d\d/
        end.should raise_error
      end
    end

    it "not a String or Regexp" do
      lambda do
        page_should_not_have 123
      end.should raise_error
    end
  end

end


