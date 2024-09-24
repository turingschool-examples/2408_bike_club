require './lib/bike_club'
require './lib/ride'
require './lib/biker'

RSpec.describe BikeClub do
  before(:each) do
    @bike_club1 = BikeClub.new('Bike_Club1')
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Wally", 15)
    @biker3 = Biker.new("Dahlia", 100)
    @biker1.learn_terrain!(:gravel)
    @biker1.learn_terrain!(:hills)
    @biker2.learn_terrain!(:gravel)
    @biker2.learn_terrain!(:hills)
    @biker3.learn_terrain!(:gravel)
    @biker3.learn_terrain!(:hills)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@bike_club1).to be_an_instance_of(BikeClub)
      expect(@bike_club1.name).to eq('Bike_Club1')
      expect(@bike_club1.bikers).to eq([])
    end
  end

  describe '#add_biker' do
    it 'can add a biker' do
      expect(@bike_club1.bikers).to eq([])
      @bike_club1.add_biker(@biker1)
      expect(@bike_club1.bikers).to eq([@biker1])
      @bike_club1.add_biker(@biker2)
      expect(@bike_club1.bikers).to eq([@biker1, @biker2])
    end
  end

  describe '#most_rides' do
    it 'can return the rider with the most rides' do
      @biker1.log_ride(@ride1, 100.1)
      @biker1.log_ride(@ride2, 44.4)
      @biker2.log_ride(@ride2, 63.0)
      @biker2.log_ride(@ride2, 61.9)
      @biker2.log_ride(@ride2, 62.6)
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker2)
      expect(@bike_club1.most_rides).to eq(@biker2)
    end
  end
  
  describe '#best_time' do
    it 'can return the biker with the best time' do
      @biker1.log_ride(@ride1, 100.1)
      @biker1.log_ride(@ride2, 44.4)
      @biker3.log_ride(@ride1, 88.8)
      @biker3.log_ride(@ride2, 63.0)
      @biker3.log_ride(@ride2, 61.9)
      @biker3.log_ride(@ride2, 62.6)
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker3)
      expect(@bike_club1.best_time(@ride1)).to eq(@biker3)
      expect(@bike_club1.best_time(@ride2)).to eq(@biker1)
    end
  end

  describe '#bikers_eligible' do
    it 'can return an array of eligible bikers for a ride' do
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker2)
      @bike_club1.add_biker(@biker3)
      expect(@bike_club1.bikers_eligible(@ride1)).to eq([@biker1, @biker3])
    end
  end

end