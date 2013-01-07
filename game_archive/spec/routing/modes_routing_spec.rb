require "spec_helper"

describe ModesController do
  describe "routing" do

    it "routes to #index" do
      get("/modes").should route_to("modes#index")
    end

    it "routes to #new" do
      get("/modes/new").should route_to("modes#new")
    end

    it "routes to #show" do
      get("/modes/1").should route_to("modes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/modes/1/edit").should route_to("modes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/modes").should route_to("modes#create")
    end

    it "routes to #update" do
      put("/modes/1").should route_to("modes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/modes/1").should route_to("modes#destroy", :id => "1")
    end

  end
end
