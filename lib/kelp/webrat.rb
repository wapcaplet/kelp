require 'kelp/helper'
require 'kelp/webrat/web_helper'
require 'kelp/webrat/form_helper'

module Kelp
  module Webrat
    include Helper
    include WebHelper
    include FormHelper
  end
end

