require 'spec_helper'

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Cruisers")
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
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

  it 'can tell which biker has the most rides' do
    @bike_club.add_bikers(@biker)
    @bike_club.add_bikers(@biker2)

    @biker.learn_terrain!(:gravel)
    @biker.learn_terrain!(:hills)
    @biker.log_ride(@ride1, 92.5)
    @biker.log_ride(@ride1, 91.1)
    @biker.log_ride(@ride2, 60.9)
    @biker.log_ride(@ride2, 61.6)

    expect(@biker.rides).to eq({ @ride1 => [92.5, 91.1], @ride2 => [60.9, 61.6]})

    @biker2.learn_terrain!(:gravel)
    @biker2.learn_terrain!(:hills)
    @biker2.log_ride(@ride2, 65.0) 

    expect(@biker2.rides).to eq({ @ride2 => [65.0] })

    expect(@bike_club.most_rides).to eq(@biker)
  end.
end