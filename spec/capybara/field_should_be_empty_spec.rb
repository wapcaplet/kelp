require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "field_should_be_empty" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    context "field with id" do
      it "is empty" do
        field_should_be_empty "first_name"
        field_should_be_empty "last_name"
      end
    end

    context "field with label" do
      it "is empty" do
        field_should_be_empty "First name"
        field_should_be_empty "Last name"
      end
    end
  end

  context "fails when" do
    context "field with id" do
      it "has a value" do
        fill_in "first_name", :with => "Brian"
        lambda do
          field_should_be_empty "first_name"
        end.should raise_error
      end
    end

    context "field with label" do
      it "has a value" do
        fill_in "First name", :with => "Brian"
        lambda do
          field_should_be_empty "First name"
        end.should raise_error
      end
    end
  end
end

