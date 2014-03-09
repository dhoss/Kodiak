module Searchable
  class Search
    def initialize(result, terms)
      # number of characters to display before/after search terms
      # example:
      # padding: 10
      # search terms: "this is a test"
      # search results: "what do you think this is a test"
      # padded display: "...t do you think this is a test..." 
      @padding = 10
      @results = results
      @terms   = terms
    end

    # distill search result down to n characters before and after
    # search terms
    def distill
      @results.each |r| do
        r[
          @result.index(@terms[0]), 
          @result.index(@terms[0])
        + @terms.length
        + @padding
        ]
      end
    end

    # highlight the search terms in the result
    def highlight
      @results.each |r| do
        @terms.split(' ') |t| do
          r[t] = "<b>#{t}</b>"
        end
      end
    end

    def formatted_results
      self.highlight
      self.distill
    end
  end

end
