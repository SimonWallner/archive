require 'spec_helper'

describe UsersController do

  describe "GET 'manage'" do
    it "returns http not success if not admin" do
      get 'manage'
      response.should_not be_success
    end
  end

end
