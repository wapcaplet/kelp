require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Kelp::Visibility, "should_see" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "exists" do
        should_see "Hello world"
        should_see "Goodbye world"
      end

      it "multiple exist" do
        should_see [
          "Hello world",
          "Goodbye world"
        ]
      end

      it "is within a CSS scope" do
        should_see "Hello world", :within => "#greeting"
      end

      it "is within an XPath scope" do
        should_see "Hello world", :within => "//div[@id='greeting']"
      end
    end

    context "Regexp" do
      it "matches" do
        should_see /(Hello|Goodbye) world/
      end

      it "matches within a CSS scope" do
        should_see /(Hello|Goodbye) world/, :within => "#greeting"
        should_see /(Hello|Goodbye) world/, :within => "#farewell"
      end

      it "matches within an XPath scope" do
        should_see /(Hello|Goodbye) world/, :within => "//div[@id='greeting']"
        should_see /(Hello|Goodbye) world/, :within => "//div[@id='farewell']"
      end
    end
  end

  context "fails when" do
    context "String" do
      it "does not exist" do
        lambda do
          should_see "Goodbye cruel world"
        end.should raise_error(Kelp::Unexpected)
      end

      it "any of several do not exist" do
        lambda do
          should_see [
            "Hello world",
            "Goodbye world",
            "Hello, nurse!"
          ]
        end.should raise_error(Kelp::Unexpected)
      end

      it "is not within a given CSS scope" do
        lambda do
          should_see "Goodbye world", :within => "#greeting"
        end.should raise_error(Kelp::Unexpected)
      end

      it "is not within a given XPath scope" do
        lambda do
          should_see "Goodbye world", :within => "//div[@id='greeting']"
        end.should raise_error(Kelp::Unexpected)
      end

      it "is given a nonexistent XPath scope" do
        lambda do
          should_see "Goodbye world", :within => "//div[@id='nonexistent']"
        end.should raise_error(Capybara::ElementNotFound)
      end
    end

    context "Regexp" do
      it "does not match" do
        lambda do
          should_see /(Yo|Wazzup) world/
        end.should raise_error(Kelp::Unexpected)
      end

      it "matches but is not within the scope" do
        lambda do
          should_see /Goodbye world/, :within => "#greeting"
        end.should raise_error(Kelp::Unexpected)
      end
    end
  end

end


describe Kelp::Visibility, "should_not_see" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    context "String" do
      it "does not exist" do
        should_not_see "Goodbye cruel world"
      end

      it "none of several strings exist" do
        should_not_see [
          "Hello nurse",
          "Goodbye cruel world"
        ]
      end

      it "exists but is not within the given CSS scope" do
        should_not_see "Goodbye world", :within => "#greeting"
      end

      it "exists but is not within the given XPath scope" do
        should_not_see "Goodbye world", :within => "//div[@id='greeting']"
      end
    end

    context "Regexp" do
      it "does not match" do
        should_not_see /(Yo|Wazzup) world/
      end

      it "none of several regexps match" do
        should_not_see [
          /(Yo|Wazzup) world/,
          /(Ciao|Later) world/
        ]
      end

      it "matches but is not within the scope" do
        should_not_see /Goodbye world/, :within => "#greeting"
      end
    end
  end


  context "fails when" do
    context "String" do
      it "exists" do
        lambda do
          should_not_see "Hello world"
        end.should raise_error(Kelp::Unexpected)
      end

      it "any of several exist" do
        lambda do
          should_not_see [
            "Hello nurse",
            "Goodbye cruel world",
            "Goodbye world"
          ]
        end.should raise_error(Kelp::Unexpected)
      end

      it "exists within the given CSS scope" do
        lambda do
          should_not_see "Hello world", :within => "#greeting"
        end.should raise_error(Kelp::Unexpected)
      end

      it "exists within the given XPath scope" do
        lambda do
          should_not_see "Hello world", :within => "//div[@id='greeting']"
        end.should raise_error(Kelp::Unexpected)
      end
    end

    context "Regexp" do
      it "matches" do
        lambda do
          should_not_see /(Hello|Goodbye) world/
        end.should raise_error(Kelp::Unexpected)
      end

      it "any of several regexps match" do
        lambda do
          should_not_see [
            /(Yo|Wazzup) world/,
            /(Ciao|Later) world/,
            /(Hello|Goodbye) world/
          ]
        end.should raise_error(Kelp::Unexpected)
      end

      it "matches within the scope" do
        lambda do
          should_not_see /(Hello|Goodbye) world/, :within => "#greeting"
        end.should raise_error(Kelp::Unexpected)
      end
    end

  end
end


describe Kelp::Visibility, "should_see_in_same_row" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "two strings are in the same row" do
      should_see_in_same_row ["Eric", "Edit"]
      should_see_in_same_row ["John", "Edit"]
    end

    it "two strings are in the same row within a given scope" do
      should_see_in_same_row ["Eric", "Edit"], :within => "#table_a"
      should_see_in_same_row ["John", "Edit"], :within => "#table_a"
      should_see_in_same_row ["Graham", "Edit"], :within => "#table_b"
    end

    it "two strings are in the same row, and one has single and/or double-quotes" do
      should_see_in_same_row [%{Graham "Quoted"}, "Edit"]
      should_see_in_same_row [%{"Michael's" quo'ta'tions}, "Edit"]
      should_see_in_same_row [%{Terry's "Big" thing}, "Edit"]
    end

    it "three strings are in the same row" do
      should_see_in_same_row ["Eric", "555-4444", "Edit"]
      should_see_in_same_row ["John", "666-5555", "Edit"]
    end
  end

  context "fails when" do
    it "two strings exist, but are not in the same row" do
      lambda do
        should_see_in_same_row ["Eric", "John"]
      end.should raise_error(Kelp::Unexpected)
    end

    it "two strings are in the same row, but a third is not" do
      lambda do
        should_see_in_same_row ["Eric", "Edit", "Delete"]
      end.should raise_error(Kelp::Unexpected)
    end

    it "two strings are in the same row, but outside the given scope" do
      lambda do
        should_see_in_same_row ["Eric", "Edit"], :within => "#table_b"
      end.should raise_error(Kelp::Unexpected)
    end
  end
end

describe Kelp::Visibility, "should_not_see_in_same_row" do
  before(:each) do
    visit('/home')
  end

  context "passes when" do
    it "two strings are not in the same row" do
      should_not_see_in_same_row ["Eric", "Delete"]
      should_not_see_in_same_row ["John", "Delete"]
      should_not_see_in_same_row ["Terry", "Delete"]
    end

    it "any two of three strings are not in the same row" do
      should_not_see_in_same_row ["Eric", "555-4444", "Delete"]
      should_not_see_in_same_row ["John", "666-5555", "Delete"]
      should_not_see_in_same_row ["Terry", "777-6666", "Delete"]
    end

    it "two strings are not in the same row within a given scope" do
      should_not_see_in_same_row ["Terry", "Delete"], :within => "#table_a"
    end
  end

  context "fails when" do
    it "two strings are in the same row" do
      lambda do
        should_not_see_in_same_row ["Eric", "Edit"]
      end.should raise_error(Kelp::Unexpected)
    end

    it "two strings are in the same row within a given scope" do
      lambda do
        should_not_see_in_same_row ["Eric", "Edit"], :within => "#table_a"
      end.should raise_error(Kelp::Unexpected)
    end
  end
end


describe Kelp::Visibility, "should_see_button" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "an input tag with the given value exists" do
      should_see_button "Save preferences"
      should_see_button "Save is disabled"
    end

    it "a button tag with the given value exists" do
      should_see_button "Submit person form"
    end

    it "an input tag with the given value exists within a scope" do
      should_see_button "Save preferences", :within => "#preferences_form"
      should_see_button "Save is disabled", :within => "#other_form"
    end

    it "a button tag with the given value exists within a scope" do
      should_see_button "Submit person form", :within => "#person_form"
    end
  end

  context "fails when" do
    it "an input tag with the given value does not exist" do
      lambda do
        should_see_button "Save nonexistent"
      end.should raise_error(Kelp::Unexpected)
    end

    it "an input tag with the given value exists, but in a different scope" do
      lambda do
        should_see_button "Save preferences", :within => "#person_form"
      end.should raise_error(Kelp::Unexpected)
    end
  end

end


describe Kelp::Visibility, "should_not_see_button" do
  before(:each) do
    visit('/form')
  end

  context "passes when" do
    it "an input or button tag with the given value does not exist" do
      should_not_see_button "No such button"
    end

    it "an input tag with the given value does not exist within a scope" do
      should_not_see_button "Save preferences", :within => "#person_form"
      should_not_see_button "Submit person form", :within => "#preferences_form"
    end
  end

  context "fails when" do
    it "an input tag with the given value exists" do
      lambda do
        should_not_see_button "Save preferences"
      end.should raise_error(Kelp::Unexpected)
    end

    it "a button tag with the given value exists" do
      lambda do
        should_not_see_button "Submit person form"
      end.should raise_error(Kelp::Unexpected)
    end

    it "an input tag with the given value exists in the given scope" do
      lambda do
        should_not_see_button "Save preferences", :within => "#preferences_form"
      end.should raise_error(Kelp::Unexpected)
    end
  end

end

