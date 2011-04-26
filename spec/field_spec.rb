require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kelp::Field, "field_should_be_empty" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    context "field with id" do
      it "is empty" do
        field_should_be_empty "first_name"
        field_should_be_empty "last_name"
        field_should_be_empty "biography"
      end
    end

    context "field with label" do
      it "is empty" do
        field_should_be_empty "First name"
        field_should_be_empty "Last name"
        field_should_be_empty "Life story"
      end
    end
  end

  context "fails when" do
    context "field with id" do
      it "has a value" do
        fill_in "first_name", :with => "Brian"
        lambda do
          field_should_be_empty "first_name"
        end.should raise_error(RuntimeError)
      end
    end

    context "field with label" do
      it "has a value" do
        fill_in "First name", :with => "Brian"
        lambda do
          field_should_be_empty "First name"
        end.should raise_error(RuntimeError)
      end
    end
  end
end


describe Kelp::Field, "field_should_contain" do
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
        end.should raise_error(rspec_unexpected)
      end

      it "has a different value" do
        fill_in "first_name", :with => "Judith"
        lambda do
          field_should_contain "first_name", "Brian"
        end.should raise_error(rspec_unexpected)
      end
    end

    context "field with label" do
      it "is empty" do
        lambda do
          field_should_contain "First name", "Brian"
        end.should raise_error(rspec_unexpected)
      end

      it "has a different value" do
        fill_in "First name", :with => "Judith"
        lambda do
          field_should_contain "First name", "Brian"
        end.should raise_error(rspec_unexpected)
      end
    end

  end

end


describe Kelp::Field, "fields_should_contain" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    context "fields with ids" do
      it "all match" do
        fill_in "first_name", :with => "Terry"
        fill_in "last_name", :with => "Jones"
        fields_should_contain "first_name" => "Terry", "last_name" => "Jones"
      end

      it "all match with some empty" do
        fill_in "first_name", :with => "Terry"
        fields_should_contain "first_name" => "Terry", "last_name" => ""
      end

      it "all match with some dropdowns" do
        fill_in "first_name", :with => "Terry"
        fill_in "last_name", :with => "Jones"
        select "Average", :from => "height"
        fields_should_contain "first_name" => "Terry", "last_name" => "Jones", "height" => "Average"
      end
    end

    context "fields with labels" do
      it "all match" do
        fill_in "First name", :with => "Terry"
        fill_in "Last name", :with => "Jones"
        fields_should_contain "First name" => "Terry", "Last name" => "Jones"
      end

      it "all match with some empty" do
        fill_in "First name", :with => "Terry"
        fields_should_contain "First name" => "Terry", "Last name" => ""
      end

      it "all match with some dropdowns" do
        fill_in "First name", :with => "Terry"
        fill_in "Last name", :with => "Jones"
        select "Average", :from => "Height"
        fields_should_contain "First name" => "Terry", "Last name" => "Jones", "Height" => "Average"
      end
    end
  end

  context "fails when" do
    context "fields with ids" do
      it "are empty" do
        lambda do
          fields_should_contain "first_name" => "Terry", "last_name" => "Jones"
        end.should raise_error(rspec_unexpected)
      end

      it "do not all match" do
        fill_in "first_name", :with => "Terry"
        fill_in "last_name", :with => "Gilliam"
        lambda do
          fields_should_contain "first_name" => "Terry", "last_name" => "Jones"
        end.should raise_error(rspec_unexpected)
      end
    end

    context "fields with labels" do
      it "are empty" do
        lambda do
          fields_should_contain "First name" => "Terry", "Last name" => "Jones"
        end.should raise_error(rspec_unexpected)
      end

      it "do not all match" do
        fill_in "First name", :with => "Terry"
        fill_in "Last name", :with => "Gilliam"
        lambda do
          fields_should_contain "First name" => "Terry", "Last name" => "Jones"
        end.should raise_error(rspec_unexpected)
      end
    end

  end

end


describe Kelp::Field, "fill_in_field" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "filling a single field by id" do
      fill_in_field "first_name", "Mel"
      field_should_contain "first_name", "Mel"
    end

    it "filling a single field by label" do
      fill_in_field "First name", "Mel"
      field_should_contain "First name", "Mel"
    end

    it "filling a single field by id within a scope" do
      fill_in_field_within "#person_form", "first_name", "Mel"
      field_should_contain_within "#person_form", "first_name", "Mel"
    end
  end

  context "fails when" do
    it "filling a nonexistent field" do
      lambda do
        fill_in_field "Middle name", "Kaminsky"
      end.should raise_error(Capybara::ElementNotFound)
    end

    it "filling a field in the wrong scope" do
      lambda do
        fill_in_field_within "#other_form", "First name", "Mel"
      end.should raise_error(Capybara::ElementNotFound)
    end
  end
end


describe Kelp::Field, "fill_in_fields" do
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
      field_should_contain "first_name", "Mel", :within => "#person_form"
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
      end.should raise_error(Capybara::ElementNotFound)
    end

    it "filling a field in the wrong scope" do
      lambda do
        fill_in_fields_within "#other_form",
          "First name" => "Mel"
      end.should raise_error(Capybara::ElementNotFound)
    end
  end

end


