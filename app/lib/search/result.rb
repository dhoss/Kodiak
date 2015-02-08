require 'fluorescent'
require 'pp'
module Search
  class Result
    attr_reader :formatter, :raw
    def initialize args
      @formatter = Fluorescent.new(args)
      @raw   = args[:results]
    end
  end
end
