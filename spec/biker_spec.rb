require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
  before(:each) do
    @kenny = Biker.new('Kenny', 30)
    @athena = Biker.new('Athena', 15)
    @ride1 = Ride.new({ name: 'Walnut Creek Trail', distance: 10.7, loop: false, terrain: :hills })
    @ride2 = Ride.new({ name: 'Town Lake', distance: 14.9, loop: true, terrain: :gravel })
  end

  describe '#initialize' do
    it 'has attributes' do
      expect(@kenny.name).to eq 'Kenny'
      expect(@kenny.age).to eq 30
    end
  end

  describe '#learn_terrain!' do
    it 'can learn terrain' do
      expect(@kenny.acceptable_terrain).to eq []
      @kenny.learn_terrain!(:surface_of_the_moon)
      expect(@kenny.acceptable_terrain).to eq [:surface_of_the_moon]
      @kenny.learn_terrain!(:mickeys_magical_ears)
      expect(@kenny.acceptable_terrain).to eq %i[mickeys_magical_ears surface_of_the_moon]
    end
  end

  describe '#log_ride' do
    it 'can log a ride' do
      expect(@athena.log_ride(@ride1, 97.0)).to eq false
      # biker2 doesn't know this terrain yet
      @athena.learn_terrain!(:gravel)
      expect(@athena.log_ride(@ride2, 67.0)).to eq true
      expect(@athena.rides).to eq({ @ride2 => [67.0] })
    end
  end

  describe '#personal_record' do
    it 'can return the best time for a ride' do
      @athena.learn_terrain!(:gravel)
      @athena.log_ride(@ride2, 67.0)
      @athena.log_ride(@ride2, 66.0)
      expect(@athena.personal_record(@ride2)).to eq 66.0 # happy
      expect(@athena.personal_record(@ride1)).to eq false # sad
    end
  end
end
