require 'spec_helper'

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Cruisers")
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    # @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    # @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@bike_club).to be_an_instance_of(BikeClub)
    end
  end

  it 'can add bikers' do
    @bike_club.add_bikers(@biker)

    expect(@bike_club.bikers).to eq([@biker])
  end
end