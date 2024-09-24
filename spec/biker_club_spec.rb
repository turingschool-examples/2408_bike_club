require "rspec"
require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe do
    before(:each) do

        @bike_club = BikeClub.new("Ride or Die", )
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        end

describe '#bike club' do
    it 'be an instance of' do

        expect(@bike_club).to be_an_instance_of(BikeClub)
        end

    it 'can return the club name' do

        expect(@bike_club.name).to eq("Ride or Die")
    end
    
    it 'can can add bikers in the club' do
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)

        expect(@bike_club.bikers).to eq([@biker1, @biker2])

    end
end
end