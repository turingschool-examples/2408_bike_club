require 'pry'
require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bikeclub = BikeClub.new("Rupert's Low Riders")
        @bikeclub2= BikeClub.new("Betty's Bikers")
        @biker = Biker.new("Kenny", 30)
        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker2 = Biker.new("Athena", 15)
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker3 = Biker.new("Betty", 32)
        @biker3.learn_terrain!(:gravel)
        @biker3.learn_terrain!(:hills)
        @biker4 = Biker.new("Billy", 30)
        @biker4.learn_terrain!(:gravel)
        @biker4.learn_terrain!(:hills)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    describe "initialize" do
        it 'can initialize' do
            expect(@bikeclub).to be_an_instance_of(BikeClub)
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
            expect(@bikeclub.bikers).to eq([@biker,@biker2])
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

    describe "#best_time" do
        it 'can find the rider with the best time for a given ride' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride2, 65.0)

            expect(@bikeclub.best_time(@ride2)).to eq(@biker)
            expect(@bikeclub.best_time(@ride1)).to eq(@biker)
        end
    end

    describe '#bikers_eligible' do
        it 'can give an array of bikers eligible for a ride' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)

            expect(@bikeclub.bikers_eligible(@ride1)).to eq([@biker])
            expect(@bikeclub.bikers_eligible(@ride2)).to eq([@biker,@biker2])
        end
    end

    # describe '#record_group_ride' do
    #     it 'can record a group ride' do
    #         @bikeclub.add_biker(@biker)
    #         @bikeclub.add_biker(@biker2)
    #     expect(@bikeclub.record_group_ride(@ride2)).to eq
    #     end
    # end

    describe '#best_rider of all bikeclub instances' do
        it 'can give a best time across all bikeclub instances for a given ride' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride2, 65.0)
            @bikeclub2.add_biker(@biker3)
            @bikeclub2.add_biker(@biker4)
            @biker3.log_ride(@ride1, 89.5)
            @biker4.log_ride(@ride1, 91.1)
            @biker4.log_ride(@ride2, 65.9)
            @biker3.log_ride(@ride2, 68.6)

            expect(BikeClub.best_time(@ride1)).to eq(@biker3)
            expect(BikeClub.best_time(@ride2)).to eq(@biker)
        end
    end
end