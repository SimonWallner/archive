require 'spec_helper'

describe Mode do
  describe "create from string" do
    it "adds modes represented by a comma-sperated string to the db" do
      mode_string = "mode1, mode2, mode3"
      created_modes = Mode.create_from_string mode_string

      modes = Mode.all
      modes.size.should eq(3)
    end
  end
end
