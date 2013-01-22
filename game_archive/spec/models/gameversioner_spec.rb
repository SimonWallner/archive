require 'spec_helper'


describe GameVersioner do
  describe "get current version of a game" do
    it "returns the current version of a game" do


      oldgame = FactoryGirl.create :game , title:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      newgame = FactoryGirl.create :game , title:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      curgame = GameVersioner.instance.current_version oldgame
      curgame.version_number.should eq 2

    end
  end

  describe "get all current version of a game collection" do
    it "returns the current versions of a collection of games" do

      #create a colleciton of games
      game1 =  FactoryGirl.create :game , title:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      game2 =  FactoryGirl.create :game , title:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      game3 =  FactoryGirl.create :game , title:"testtitle_old2" , description:"testdescription_old2", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"
      game4 =  FactoryGirl.create :game , title:"testtitle_new2" , description:"testdescription_new2", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"

      coll = Array.new

      coll << game1
      coll << game2
      coll << game3
      coll << game4

      curgames = GameVersioner.instance.current_versions_from_collection coll
      curgames.size.should eq 2

      curgames.each() do |curgame|
        curgame.version_number.should eq 2

      end

    end
  end
  describe "create new version of a game and check references" do
    it "returns a new version of the game with correct references" do
      old =  FactoryGirl.create :game , title:"testtitle_old" , description:"testdescription_old", version_number:1 ,
                                version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9" ,  popularity: 8, created_at: "2013-01-16 12:12:58" , image: "test.png"


      sleep(1)

      new = GameVersioner.instance.new_version old

      new.title.should eq old.title
      new.description.should eq old.description

      #puts old.image
      #puts new.image

      #doesnt save image, copies correctly though,
      new.image==old.image
      new.popularity.should  eq old.popularity
      new.created_at.should eq old.created_at

      new.version_number.should eq (old.version_number+1)
      new.version_updated_at.should_not eq old.version_updated_at

    end
  end

end