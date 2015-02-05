require 'fluorescent'
require 'pp'
module Search
  class Result
    attr_reader :columns, :to_filter
    def Result.new args
      pp args
      f = Fluorescent.new(args)
      pp f.formatted_results
      return f
    end
  end
end
