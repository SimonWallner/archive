require 'spec_helper'

describe Platform do
  describe "create from string" do
    it "adds platforms represented by a comma-sperated string to the db" do
      platform_string = "platform1, platform2, platform3"
      created_platforms = Platform.create_from_string platform_string

      platforms = Platform.all
      platforms.size.should eq(3)
    end
  end
end
