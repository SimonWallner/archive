require 'spec_helper'

describe Genre do

  describe "create from string" do
    it "adds genres represented by a comma-sperated string to the db" do
      genre_string = "genre1,genre2, genre3"
      created_genres = Genre.create_from_string genre_string

      genres = Genre.all
      genres.size.should eq(3)
    end
  end
end
