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


describe FormHelper, "#fields_should_contain" do
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
        end.should raise_error
      end

      it "do not all match" do
        fill_in "first_name", :with => "Terry"
        fill_in "last_name", :with => "Gilliam"
        lambda do
          fields_should_contain "first_name" => "Terry", "last_name" => "Jones"
        end.should raise_error
      end
    end

    context "fields with labels" do
      it "are empty" do
        lambda do
          fields_should_contain "First name" => "Terry", "Last name" => "Jones"
        end.should raise_error
      end

      it "do not all match" do
        fill_in "First name", :with => "Terry"
        fill_in "Last name", :with => "Gilliam"
        lambda do
          fields_should_contain "First name" => "Terry", "Last name" => "Jones"
        end.should raise_error
      end
    end

  end

end

