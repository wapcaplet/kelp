module Kelp
  class KelpError < StandardError; end
  class Unexpected < KelpError; end
  class FieldNotFound < KelpError; end
  class OptionNotFound < KelpError; end
end

