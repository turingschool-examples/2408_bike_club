require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bike_club = BikeClub.new("Twin City Terrors")
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
    end

    it 'exist' do
        expect(@bike_club.name).to eq("Twin City Terrors")
        expect(@bike_club.bikers).to eq([])
    end

    it 'can add bikers' do
        expect(@bike_club.bikers).to eq([])
    
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
    
        expect(@bike_club.bikers).to eq([@biker1, @biker2])
    end

    describe '#most_riders' do
        it 'can determine who has biked the most rides' do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 6, loop: false, terrain: :hills})
            @ride2 = Ride.new({name: "Town Lake", distance: 10, loop: true, terrain: :gravel})

            @biker1.learn_terrain(:gravel)
            @biker1.learn_terrain(:hills)
            @biker2.learn_terrain(:gravel)
            @biker2.learn_terrain(:hills)

            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 91.1)
            @biker1.log_ride(@ride2, 60.9)
            @biker1.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride1, 90.3)
            @biker2.log_ride(@ride2, 61.9)
            @biker2.log_ride(@ride2, 62.6)

            @bike_club.add_biker(@biker1)
            @bike_club.add_biker(@biker2)
            
            expect(@bike_club.most_rides).to eq(@biker1)
        end
    end

    describe '12. #best_time(ride)' do
        it 'can determine who has the best time for a ride' do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 6, loop: false, terrain: :hills})
            @ride2 = Ride.new({name: "Town Lake", distance: 10, loop: true, terrain: :gravel})
            
            @biker1.learn_terrain(:gravel)
            @biker1.learn_terrain(:hills)
            @biker2.learn_terrain(:gravel)
            @biker2.learn_terrain(:hills)

            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 91.1)
            @biker1.log_ride(@ride2, 60.9)
            @biker1.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride1, 90.3)
            @biker2.log_ride(@ride2, 61.9)
            @biker2.log_ride(@ride2, 62.6)

            @bike_club.add_biker(@biker1)
            @bike_club.add_biker(@biker2)

            expect(@bike_club.best_time(@ride1)).to eq(@biker2)
            expect(@bike_club.best_time(@ride2)).to eq(@biker1)
        end
     end

    describe '13. #bikers_eligible(ride)' do
        it 'can determine who has the best time for a ride' do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 6, loop: false, terrain: :hills})
            @ride2 = Ride.new({name: "Town Lake", distance: 10, loop: true, terrain: :gravel})

            @biker1.learn_terrain(:gravel)
            @biker1.learn_terrain(:hills)
            @biker2.learn_terrain(:gravel)

            @bike_club.add_biker(@biker1)
            @bike_club.add_biker(@biker2)

            expect(@bike_club.bikers_eligible(@ride1)).to eq([@biker1])
            expect(@bike_club.bikers_eligible(@ride2)).to eq([@biker1, @biker2])
        end
    end
end