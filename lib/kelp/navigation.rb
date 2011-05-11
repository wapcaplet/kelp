require 'uri'
require 'cgi'
require 'kelp/scoping'
require 'kelp/xpath'

module Kelp
  # This module defines helper methods for navigating a webpage, including
  # clicking links and pressing buttons, and for verifying the current
  # page's path and query parameters.
  #
  module Navigation
    include Scoping
    include XPaths

    # Follow a link on the page.
    #
    # @example
    #   follow "Login"
    #   follow "Contact Us", :within => "#footer"
    #
    # @param [String] link
    #   Capybara locator expression (id, name, or link text)
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    def follow(link, scope={})
      in_scope(scope) do
        click_link(link)
      end
    end

    # Press a button on the page.
    #
    # @example
    #   press "Cancel"
    #   press "Submit", :within => "#survey"
    #
    # @param [String] button
    #   Capybara locator expression (id, name, or button text)
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    def press(button, scope={})
      in_scope(scope) do
        click_button(button)
      end
    end


    # Click a link in a table row containing the given text.
    #
    # @example
    #   click_link_in_row "Edit", "Pinky"
    #
    # @param [String] link
    #   Content of the link to click
    # @param [String] text
    #   Other content that must be in the same row
    #
    def click_link_in_row(link, text)
      row = find(:xpath, xpath_row_containing([link, text]))
      row.click_link(link)
    end


    def go_to_page(page_name_or_path)
      if defined? path_to
        visit path_to(page_name_or_path)
      else
        visit page_name_or_path
      end
    end


    # Verify that the current page matches the path of `page_name_or_path`. The
    # cucumber-generated `path_to` function will be used, if it's defined, to
    # translate human-readable names into URL paths. Otherwise, assume a raw,
    # absolute path string.
    #
    # @example
    #   should_be_on_page 'home page'
    #   should_be_on_page '/admin/login'
    #
    # @param [String] page_name_or_path
    #   Human-readable page name (mapped to a pathname by your `path_to` function),
    #   or an absolute path beginning with `/`.
    #
    # @raise [Kelp::Unexpected]
    #   If actual page path doesn't match the expected path
    #
    # @since 0.1.9
    #
    def should_be_on_page(page_name_or_path)
      # Use the path_to translator function if it's defined
      # (normally in features/support/paths.rb)
      if defined? path_to
        expect_path = path_to(page_name_or_path)
      # Otherwise, expect a raw path string
      else
        expect_path = page_name_or_path
      end
      actual_path = URI.parse(current_url).path
      if actual_path != expect_path
        raise Kelp::Unexpected,
          "Expected to be on page: '#{expect_path}'" + \
          "\nActually on page: '#{actual_path}'"
      end
    end


    # Verify that the current page has the given query parameters.
    #
    # @param [Hash] params
    #   Key => value parameters, as they would appear in the URL
    #
    # @raise [Kelp::Unexpected]
    #   If actual query parameters don't match expected parameters
    #
    # @since 0.1.9
    #
    def should_have_query(params)
      query = URI.parse(current_url).query
      actual_params = query ? CGI.parse(query) : {}
      expected_params = {}
      params.each_pair do |k,v|
        expected_params[k] = v.split(',')
      end
      if actual_params != expected_params
        raise Kelp::Unexpected,
          "Expected query params: '#{expected_params.inspect}'" + \
          "\nActual query params: '#{actual_params.inspect}'"
      end
    end

  end
end
