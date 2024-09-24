require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before(:each) do
        @bike_club = BikeClub.new('flying bike club')
        @biker = Biker.new("Kenny", 30) 
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
       
        @biker.learn_terrain(:hills)
        @biker.learn_terrain(:gravel)
        @biker.log_ride(@ride1, 95.3)
        @biker.log_ride(@ride2, 60.7)
        
        @biker2.learn_terrain(:gravel)
        @biker2.log_ride(@ride2, 65.4)
    end

      it 'exists' do
        expect(@bike_club).to be_an_instance_of(BikeClub)
        expect(@bike_club.name).to eq("flying bike club")
      end
    
      it 'can hav and add bikers' do
        expect(@bike_club.bikers).to eq([])
        
        @bike_club.add_biker(@biker)
        @bike_club.add_biker(@biker2)
        
        expect(@bike_club.bikers).to eq([@biker, @biker2])
      end
    
      it 'can return the biker with the most rides' do
        @bike_club.add_biker(@biker)
        @bike_club.add_biker(@biker2)
    
        expect(@bike_club.most_rides).to eq(@biker)
      end
    
      it 'can return biker with the best time for a ride' do
        @bike_club.add_biker(@biker)
        @bike_club.add_biker(@biker2)
    
        expect(@bike_club.best_time(@ride2)).to eq(@biker)
      end
    
      it 'can tell which bikers are eligible for a ride' do
        @bike_club.add_biker(@biker)
        @bike_club.add_biker(@biker2)
    
        expect(@bike_club.bikers_eligible(@ride1)).to eq([@biker]) 
        expect(@bike_club.bikers_eligible(@ride2)).to eq([@biker, @biker2]) 
      end
    
end