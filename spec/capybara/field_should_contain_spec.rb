require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FormHelper, "#field_should_contain" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    context "field with id" do
      it "has the given value" do
        fill_in "first_name", :with => "Brian"
        field_should_contain "first_name", "Brian"
      end
    end

    context "field with label" do
      it "has the given value" do
        fill_in "First name", :with => "Brian"
        field_should_contain "First name", "Brian"
      end
    end
  end

  context "fails when" do
    context "field with id" do
      it "is empty" do
        lambda do
          field_should_contain "first_name", "Brian"
        end.should raise_error
      end

      it "has a different value" do
        fill_in "first_name", :with => "Judith"
        lambda do
          field_should_contain "first_name", "Brian"
        end.should raise_error
      end
    end

    context "field with label" do
      it "is empty" do
        lambda do
          field_should_contain "First name", "Brian"
        end.should raise_error
      end

      it "has a different value" do
        fill_in "First name", :with => "Judith"
        lambda do
          field_should_contain "First name", "Brian"
        end.should raise_error
      end
    end

  end

end

