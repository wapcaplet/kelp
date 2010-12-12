require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FormHelper, "#dropdown_should_equal" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "the option has the selected attribute" do
      dropdown_should_equal "Height", "Average"
    end

    it "the option is chosen programmatically" do
      select "Short", :from => "Height"
      dropdown_should_equal "Height", "Short"

      select "Tall", :from => "Height"
      dropdown_should_equal "Height", "Tall"
    end
  end

  context "fails when" do
    it "the option does not have the selected attribute" do
      lambda do
        dropdown_should_equal "Height", "Tall"
      end.should raise_error
    end

    it "the option was not the one chosen programmatically" do
      select "Tall", :from => "Height"
      lambda do
        dropdown_should_equal "Height", "Average"
      end.should raise_error
    end
  end

end

describe FormHelper, "#dropdown_should_include" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "a single option exists in the dropdown" do
      dropdown_should_include "Height", "Short"
      dropdown_should_include "Height", "Average"
      dropdown_should_include "Height", "Tall"
    end

    it "multiple options exist in the dropdown" do
      dropdown_should_include "Height", [
        "Short",
        "Average",
        "Tall",
      ]
    end
  end

  context "fails when" do
    it "a single option does not exist in the dropdown" do
      lambda do
        dropdown_should_include "Height", "Midget"
      end.should raise_error
    end

    it "any of several options do not exist in the dropdown" do
      lambda do
        dropdown_should_include "Height", [
          "Short",
          "Average",
          "Tall",
          "Giant",
        ]
      end.should raise_error
    end
  end

end

