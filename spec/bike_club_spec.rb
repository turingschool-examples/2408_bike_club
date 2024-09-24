require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bike_club = BikeClub.new('Bike Club')
    end

    it 'exits with no bikers initially' do
        expect(@bike_club.bikers).to eq([])  # This is now valid since no bikers are added yet
    end
        
    it 'can add bikers' do
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @biker3 = Biker.new("Leo", 25)
        @biker4 = Biker.new("Sophia", 20)

        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        @bike_club.add_biker(@biker3)
        @bike_club.add_biker(@biker4)

        expect(@bike_club.bikers).to include(@biker1, @biker2, @biker3, @biker4)
    end

    it 'can count the most rides and best times' do
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @biker3 = Biker.new("Leo", 25)
        @biker4 = Biker.new("Sophia", 20)

        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        @bike_club.add_biker(@biker3)
        @bike_club.add_biker(@biker4)

        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
        @biker1.log_ride(@ride1, 92.5)
        @biker1.log_ride(@ride2, 60.9)

        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2.log_ride(@ride1, 95.0)

        @biker3.learn_terrain!(:gravel)
        @biker3.learn_terrain!(:hills)
        @biker3.log_ride(@ride1, 97.5)

        @biker4.learn_terrain!(:gravel)
        @biker4.learn_terrain!(:hills)
        @biker4.log_ride(@ride1, 98.5)

        expect(@bike_club.most_rides).to eq(@biker1)
        expect(@bike_club.best_time(@ride1)).to eq(@biker1)
    end
end