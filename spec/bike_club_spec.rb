require 'pry'
require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bikeclub = BikeClub.new("Rupert's Low Riders")
        @biker = Biker.new("Kenny", 30)
        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    describe "initialize" do
        it 'can initialize' do
            expect(@bike_club).to be_an_instance_of(BikeClub)
        end
        
        it 'has attributes' do
            expect(@bikeclub.name).to eq("Rupert's Low Riders")
            expect(@bikeclub.bikers).to eq([])
        end
    end

    describe "#add_biker" do
        it 'can add bikers' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)
            expect(@bike_club.bikers).to eq([@biker,@biker1])
        end
    end

    describe "#most_rides" do
        it 'can find the rider with the most rides' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride2, 65.0)
            
            expect(@bikeclub.most_rides).to eq(@biker)
        end
    end
end