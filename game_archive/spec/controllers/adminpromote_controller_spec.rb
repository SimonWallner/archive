require 'spec_helper'

describe AdminpromoteController do

  describe "GET 'promote'" do
    it "returns http success" do
      get 'promote'
      response.should be_success
    end
  end

end
