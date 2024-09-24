require 'spec_helper'

RSpec.describe Ride do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@ride1).to be_an_instance_of(Ride)
    end

    it 'has a name' do
      expect(@ride1.name).to eq("Walnut Creek Trail")
    end

    it 'has a distance' do
      expect(@ride1.distance).to eq(10.7)
    end

    it 'has a terrain' do
      expect(@ride1.terrain).to eq(:hills)
    end

    it 'can tell if its a loop by default' do
      expect(@ride1.loop?).to eq(false)
    end
  end

  it 'can calculate total distance' do
    expect(@ride1.total_distance).to eq(21.4)
    expect(@ride2.total_distance).to eq(14.9)
  end
end