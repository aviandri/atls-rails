require 'spec_helper'

describe TrainingSchedule do
  

  describe "scope training schedule by location" do
    it "should return all schedule for a particular training location" do
      	TrainingSchedule.location_jakarta
    end
  end
end
