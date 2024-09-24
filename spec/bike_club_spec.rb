require 'spec_helper'
RSpec.describe BikeClub do 
    before(:each) do 
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        @ride3 = Ride.new({name: "High Cliff", distance: 20, loop: false, terrain: :mountain})
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @biker3 = Biker.new("Bob", 20)
        @club = BikeClub.new('Pauls Club')
    end

    describe 'initialize' do 
        it 'exists' do
            expect(@club).to be_an_instance_of(BikeClub)
        end

        it 'has a name' do 
            expect(@club.name).to eq('Pauls Club')
        end

        it 'has bikers' do 
            expect(@club.bikers).to eq([])
        end
    end

    describe 'add bikers' do
        it 'can add bikers' do
            @club.add_biker(@biker1)
            @club.add_biker(@biker2)
            @club.add_biker(@biker3)
            expect(@club.bikers).to eq([@biker1, @biker2, @biker3])
        end
    end

    describe "#most_rides" do
        it "returns the biker with the most rides" do
            @club.add_biker(@biker1)
            @club.add_biker(@biker2)
            @biker1.learn_terrain!(:hills)
            @biker2.learn_terrain!(:hills)
            @biker1.log_ride(@ride1, 100)
            @biker1.log_ride(@ride1, 95)
            @biker2.log_ride(@ride1, 110)
            expect(@club.most_rides).to eq(@biker1)
        end
    end

    describe "#bikers_eligible" do
        it "returns bikers eligible for a given ride" do
            @club.add_biker(@biker1)
            @club.add_biker(@biker2)
            @club.add_biker(@biker3)
            @biker1.learn_terrain!(:hills)
            @biker2.learn_terrain!(:hills)
            @biker3.learn_terrain!(:hills)
            expect(@club.bikers_eligible(@ride1)).to eq([@biker1])
        end
    end
end



