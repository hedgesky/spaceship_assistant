require 'colorize'
require 'os'

if OS.windows?
  class String
    def colorize(color)
      self
    end
  end
end