require 'GameVerisoner'


describe GameVersioner do
  describe "get current version of a game" do
    it "returns the current version of a game" do


      oldgame = FactoryGirl.create :game , title:"testtitle_old" , description:"testdescription_old", version_number:1

      newgame = FactoryGirl.create :game , title:"testtitle_new" , description:"testdescription_new", version_number:2

      #curgame = GameVersioner.instance.current_version oldgame
     # curgame.version_number.should eq 2

    end
  end
end