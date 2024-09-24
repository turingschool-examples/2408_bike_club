require "rspec"
require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe do
    before(:each) do

        @bike_club = BikeClub.new("Ride or Die", )
        @biker1 = Biker.new("Kenny", 30)
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

    it 'can tell which biker has the best time for a given ride' do
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
    
        @biker1.log_ride(@ride1, 25.0) 
        @biker1.log_ride(@ride2, 15.0) 
        @biker2.log_ride(@ride1, 30.0)
    
        expect(@bike_club.best_time(@ride1)).to eq(@biker1)
      end
    
      it 'can tell which bikers are eligible for a given ride' do
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)

        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
    
        @biker1.log_ride(@ride1, 25.0) 
        @biker1.log_ride(@ride2, 15.0) 
        @biker2.log_ride(@ride1, 30.0)
    

        expect(@bike_club.bikers_eligible(@ride1)).to contain_exactly(@biker1)
        expect(@bike_club.bikers_eligible(@ride2)).to contain_exactly(@biker1)
      end

end
end