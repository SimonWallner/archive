require 'spec_helper'

describe Medium do
  describe "create from string" do
    it "adds media represented by a comma-sperated string to the db" do
      medium_string = "medium1, medium2, medium3"
      created_media = Medium.create_from_string medium_string

      media = Medium.all
      media.size.should eq(3)
    end
  end
end
