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
      @bike_club1.add_biker(@biker1)
      expect(@bike_club1.bikers).to eq([@biker1, @biker2])
    end
  end
end