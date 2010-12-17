require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "fill_in_fields" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "filling a single field by id" do
      fill_in_fields "first_name" => "Mel"
      field_should_contain "first_name", "Mel"
    end

    it "filling a single field by label" do
      fill_in_fields "First name" => "Mel"
      field_should_contain "First name", "Mel"
    end

    it "filling multiple fields by id" do
      fill_in_fields \
        "first_name" => "Mel",
        "last_name" => "Brooks"
      field_should_contain "first_name", "Mel"
      field_should_contain "last_name", "Brooks"
    end

    it "filling multiple fields by label" do
      fill_in_fields \
        "First name" => "Mel",
        "Last name" => "Brooks"
      field_should_contain "First name", "Mel"
      field_should_contain "Last name", "Brooks"
    end

    it "filling a single field by id within a scope" do
      fill_in_fields_within "#person_form", "first_name" => "Mel"
      field_should_contain "first_name", "Mel"
    end

    it "filling multiple fields by id within a scope" do
      fill_in_fields_within "#person_form",
        "first_name" => "Mel",
        "last_name" => "Brooks"
      fields_should_contain_within "#person_form",
        "first_name" => "Mel",
        "last_name" => "Brooks"
    end
  end

  context "fails when" do
    it "filling a nonexistent field" do
      lambda do
        fill_in_fields "Middle name" => "Kaminsky"
      end.should raise_error
    end

    it "filling a field in the wrong scope" do
      lambda do
        fill_in_fields_within "#other_form",
          "First name" => "Mel"
      end.should raise_error
    end
  end

end


