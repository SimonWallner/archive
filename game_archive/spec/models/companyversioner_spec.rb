require 'spec_helper'


describe CompanyVersioner do
  describe "get current version of a company" do
    it "returns the current version of a company" do


      oldcompany = FactoryGirl.create :company , name:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      newcompany = FactoryGirl.create :company , name:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

      curcomp = CompanyVersioner.instance.current_version oldcompany
      curcomp.version_number.should eq 2

    end
  end

  describe "get all current version of a company collection" do
    it "returns the current versions of a collection of companies" do

      #create a colleciton of games
      company1 =  FactoryGirl.create :company , name:"testtitle_old" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      company2 =  FactoryGirl.create :company , name:"testtitle_new" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
      company3 =  FactoryGirl.create :company , name:"testtitle_old2" , description:"testdescription_old2", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"
      company4 =  FactoryGirl.create :company , name:"testtitle_new2" , description:"testdescription_new2", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632abc"

      coll = Array.new

      coll << company1
      coll << company2
      coll << company3
      coll << company4

      curcompanies = CompanyVersioner.instance.current_versions_from_collection coll
      curcompanies.size.should eq 2

      curcompanies.each() do |curcompany|
        curcompany.version_number.should eq 2

      end

    end
  end

end