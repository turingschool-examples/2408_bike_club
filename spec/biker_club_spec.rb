require "rspec"
require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe do
    before(:each) do

        @bike_club = BikeClub.new("Ride or Die", )
        end

describe '#bike club' do
    it 'be an instance of' do

        expect(@bike_club).to be_an_instance_of(BikeClub)
        end
    end
end