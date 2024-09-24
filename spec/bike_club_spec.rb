require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bikeclub = BikeClub.new("Awesome Bike Club")
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)

        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) 
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)

        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)
    end

    describe '#initialize' do
        it 'exists' do
            expect(@bikeclub).to be_instance_of(BikeClub)
            expect(@bikeclub.name).to eq("Awesome Bike Club")
        end

        it 'starts with an empty array of bikers' do
            expect(@bikeclub.bikers).to eq([])
        end
    end

    describe '#bikers' do
        it 'can add bikers' do
            @bikeclub.add_biker(@biker)

            expect(@bikeclub.bikers).to include(@biker)
        end

        it 'can add more bikers' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)

            expect(@bikeclub.bikers).to include(@biker, @biker2)
        end
    end

    describe '#rides' do
        it 'can identify the biker with the most rides' do
            @bikeclub.add_biker(@biker)

            expect(@bikeclub.most_rides).to eq(@biker)
        end

        it 'identifies bikers eligible for a ride' do
            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)

            expect(@bikeclub.bikers_eligible(@ride1)).to eq([@biker])
        end

    end

    describe '#times' do
        it 'can identify the biker with the best time' do
            @bikeclub = BikeClub.new("Awesome Bike Club")

            @biker = Biker.new("Kenny", 30)
            @biker2 = Biker.new("Athena", 15)

            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) 
            @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)

            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)

            @biker2.learn_terrain!(:gravel)
            @biker2.learn_terrain!(:hills)

            @biker2.log_ride(@ride2, 90.0)
            @biker2.log_ride(@ride2, 55.0)

            @bikeclub.add_biker(@biker)
            @bikeclub.add_biker(@biker2)

            best_biker = @bikeclub.best_time(@ride2)
            expect(best_biker(@ride1)).to eq(@biker)
        end
    end
end