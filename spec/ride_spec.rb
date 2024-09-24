require './lib/ride'

RSpec.describe Ride do

  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ride1).to be_an_instance_of(Ride)
      expect(@ride1.name).to eq('Walnut Creek Trail')
      expect(@ride1.distance).to eq(10.7)
      expect(@ride1.terrain).to eq(:hills)
    end
  end

  describe '#loop?' do
    it 'can return if a ride is not a loop' do
      expect(@ride1.loop?).to eq(false)
    end

    it 'can return is a loop' do
      expect(@ride2.loop?).to eq(true)
    end
  end

  describe '#total_distance' do
    it 'can provide the total distance of a loop' do
      expect(@ride2.total_distance).to eq(14.9)
    end

    it 'can provide the total distance if it is not a loop' do
      expect(@ride1.total_distance).to eq(21.4)
    end
  end
end