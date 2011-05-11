module Kelp
  class KelpError < StandardError; end
  class Unexpected < KelpError; end
  class FieldNotFound < KelpError; end
  class OptionNotFound < KelpError; end
  class MissingLink < KelpError; end
  class MissingButton < KelpError; end
  class MissingRow < KelpError; end
  class InvalidScope < KelpError; end
end

