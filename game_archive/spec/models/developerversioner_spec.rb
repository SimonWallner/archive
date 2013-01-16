require 'spec_helper'


describe DeveloperVersioner do
  describe "get current version of a developer" do
    it "returns the current version of a developer" do


      olddeveloper = FactoryGirl.create :developer , name:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      newdeveloper = FactoryGirl.create :developer , name:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      curdeveloper = DeveloperVersioner.instance.current_version olddeveloper
      curdeveloper.version_number.should eq 2

    end
  end

  describe "get all current version of a game collection" do
    it "returns the current versions of a collection of games" do

      #create a colleciton of games
      developer1 =  FactoryGirl.create :developer , name:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      developer2 =  FactoryGirl.create :developer , name:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      developer3 =  FactoryGirl.create :developer , name:"testtitle_old2" , description:"testdescription_old2", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"
      developer4 =  FactoryGirl.create :developer , name:"testtitle_new2" , description:"testdescription_new2", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"

      coll = Array.new

      coll << developer1
      coll << developer2
      coll << developer3
      coll << developer4

      curdevelopers = DeveloperVersioner.instance.current_versions_from_collection coll
      curdevelopers.size.should eq 2

      curdevelopers.each() do |curdeveloper|
        curdeveloper.version_number.should eq 2

      end

    end
  end
end