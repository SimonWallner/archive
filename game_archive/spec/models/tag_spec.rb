require 'spec_helper'

describe Tag do
  describe "create from string" do
    it "adds tags represented by a comma-sperated string to the db" do
      tag_string = "tag1,tag2, tag3"
      created_tags = Tag.create_from_string tag_string

      tags = Tag.all
      tags.size.should eq(3)
    end
  end
end
