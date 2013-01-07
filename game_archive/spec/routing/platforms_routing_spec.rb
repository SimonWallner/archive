require "spec_helper"

describe PlatformsController do
  describe "routing" do

    it "routes to #index" do
      get("/platforms").should route_to("platforms#index")
    end

    it "routes to #new" do
      get("/platforms/new").should route_to("platforms#new")
    end

    it "routes to #show" do
      get("/platforms/1").should route_to("platforms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/platforms/1/edit").should route_to("platforms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/platforms").should route_to("platforms#create")
    end

    it "routes to #update" do
      put("/platforms/1").should route_to("platforms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/platforms/1").should route_to("platforms#destroy", :id => "1")
    end

  end
end
