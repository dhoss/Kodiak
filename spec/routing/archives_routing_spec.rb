require 'spec_helper'

describe ArchivesController do
  describe "routing" do
    it "routes to #year" do 
      get("/2014").should route_to("archives#year", :year => "2014")
    end

    it "routes to #month" do
      get("/2014/07").should route_to("archives#month", :year => "2014", :month => "07")
    end

    it "routes to #day" do
      get("/2014/07/30").should route_to("archives#day", :year => "2014", :month => "07", :day => "30")
    end
  end
end
