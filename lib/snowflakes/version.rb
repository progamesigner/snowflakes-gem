module Snowflakes
  def self.version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 1
    MICRO = 0
    SURFIX = nil

    STRING = [MAJOR, MINOR, MICRO, SURFIX].compact.join('.')
  end
end
