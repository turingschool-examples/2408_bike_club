require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
  before(:each) do
    @kenny = Biker.new('Kenny', 30)
    @athena = Biker.new('Athena', 15)
    @ride1 = Ride.new({ name: 'Walnut Creek Trail', distance: 10.7, loop: false, terrain: :hills })
    @ride2 = Ride.new({ name: 'Town Lake', distance: 14.9, loop: true, terrain: :gravel })
    @athena.learn_terrain!(:gravel)
    @athena.log_ride(@ride2, 67.0)
    @athena.log_ride(@ride2, 65.0)
    @kenny.learn_terrain!(:gravel)
    @kenny.log_ride(@ride2, 67.0)
    @club = BikeClub.new('SLO Riderz')
  end

  describe '#name' do
    it 'has a name' do
      expect(@club.name).to eq 'SLO Riderz'
    end
  end

  describe '#bikers' do
    it 'has an array of bikers' do
      expect(@club.bikers).to eq []
    end
  end

  describe '#add_biker' do
    it 'can add a biker' do
      expect(@club.add_biker(@kenny)).to eq [@kenny]
    end
  end

  describe '#best_time' do
    it 'can return the best time for a ride' do
      @club.add_biker(@kenny)
      expect(@club.best_time(@ride2)).to eq @kenny
    end
  end

  describe '#bikers eligible' do
    it 'can return array of bikers eligible for a ride' do
      @club.add_biker(@kenny)
      @club.add_biker(@athena)
      expect(@club.bikers_eligible(@ride2)).to eq [@kenny, @athena]
    end
  end
end
