require './lib/ride'
require './lib/biker'

RSpec.describe Biker do

  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Wally", 15)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@biker1).to be_an_instance_of(Biker)
      expect(@biker1.name).to eq('Kenny')
      expect(@biker1.max_distance).to eq(30)
      expect(@biker1.rides).to eq({})
      expect(@biker1.acceptable_terrain).to eq([])
    end
  end

  describe '#learn_terrain!' do
    it 'can learn a new terrain' do
      expect(@biker1.acceptable_terrain).to eq([])
      @biker1.learn_terrain!(:gravel)
      expect(@biker1.acceptable_terrain).to eq([:gravel])
      @biker1.learn_terrain!(:hills)
      expect(@biker1.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe '#log_ride' do
    it 'can log a ride' do
      @biker1.learn_terrain!(:hills)
      @biker1.learn_terrain!(:gravel)
      expect(@biker1.rides).to eq({})
      @biker1.log_ride(@ride1, 92.5)
      expect(@biker1.rides).to eq({@ride1 => [92.5]})
      @biker1.log_ride(@ride2, 60.9)
      expect(@biker1.rides).to eq({@ride1 => [92.5], @ride2 => [60.9]})
    end

    it 'can log multiple times of the same ride' do
      @biker1.learn_terrain!(:hills)
      @biker1.learn_terrain!(:gravel)
      expect(@biker1.rides).to eq({})
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 90.1)
      expect(@biker1.rides).to eq({@ride1 => [92.5, 90.1]})
    end

    it 'cannot log a ride if the biker does not know the terrain' do
      expect(@biker2.rides).to eq({})
      @biker2.log_ride(@ride2, 92.5)
      expect(@biker2.rides).to eq({})
      @biker2.learn_terrain!(:gravel)
      @biker2.log_ride(@ride2, 92.5)
      expect(@biker2.rides).to eq({@ride2 => [92.5]})
    end

    it 'cannot log a ride if the max distance is greater than the rider\s max distance' do
      expect(@biker2.rides).to eq({})
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 10.1)
      expect(@biker2.rides).to eq({})
    end
  end

  describe '#personal_record' do
    it 'can provide the users personal record for a ride' do
      @biker1.learn_terrain!(:hills)
      expect(@biker1.personal_record(@ride1)).to eq(false)
      @biker1.log_ride(@ride1, 92.5)
      expect(@biker1.personal_record(@ride1)).to eq(92.5)
      @biker1.log_ride(@ride1, 90.1)
      expect(@biker1.personal_record(@ride1)).to eq(90.1)
    end
  end
end