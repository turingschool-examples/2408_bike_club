require 'spec_helper'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    # @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    # @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@biker).to be_an_instance_of(Biker)
    end

    it 'has a name' do
      expect(@biker.name).to eq("Kenny")
    end

    it 'has a max distance' do 
      expect(@biker.max_distance).to eq(30)
    end
  end

  it 'can hold rides in a hash' do
    expect(@biker.rides).to eq({})
  end

  it 'can list acceptable terrain' do
    expect(@biker.acceptable_terrain).to eq([])
  end
end