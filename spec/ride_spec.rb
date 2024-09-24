require './spec/spec_helper'

RSpec.describe Ride do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(@ride1).to be_an_instance_of(Ride)
      expect(@ride2.name).to eq("Town Lake")
      expect(@ride1.distance).to eq(10.7)
      expect(@ride2.terrain).to eq(:gravel)
      expect(@ride1.loop?).to eq(false)
    end
  end

  describe 'loop' do
    it 'knows if the ride is a loop and doubles distance if it is not' do
      expect(@ride1.loop?).to eq(false)
      expect(@ride2.loop?).to eq(true)
      expect(@ride1.total_distance).to eq(21.4)
      expect(@ride2.total_distance).to eq(14.9)
    end
  end
end
      