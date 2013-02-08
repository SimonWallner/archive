require 'spec_helper'

describe GameVersioner do
	describe "get current version of a game" do
		it "returns the current version of a game" do

			oldgame = FactoryGirl.create :game , version_number: 1, version_id: "foobar"
			newgame = FactoryGirl.create :game , version_number: 2, version_id: "foobar"

			curgame = GameVersioner.instance.current_version oldgame
			curgame.version_number.should eq 2
		end
	end
end
