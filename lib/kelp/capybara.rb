require 'kelp/helper'
require 'kelp/capybara/web_helper'
require 'kelp/capybara/form_helper'

module Kelp
  module Capybara
    include Helper
    include WebHelper
    include FormHelper
  end
end

