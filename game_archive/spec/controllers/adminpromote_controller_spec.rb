require 'spec_helper'

describe AdminpromoteController do

  describe "GET 'promote'" do
    it "returns http not success if not admin" do
      get 'promote'
      response.should_not be_success
    end
  end

end
