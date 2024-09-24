require './spec/spec_helper'

RSpec.describe BikeClub do
    before(:each) do
        @bikeclub_1 = BikeClub.new("Cohort 2408")
    end

    it 'can initialize and return variables' do
        expect(@bikeclub_1).to be_an_instance_of(BikeClub)
        expect(@bikeclub_1.name).to eq("Cohort 2408")
    end
end