require './spec/spec_helper'

RSpec.describe BikeClub do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @bike_club1 = BikeClub.new("Steve's Naughty Cats")
    @bike_club2 = BikeClub.new("Susan's Sweet kittens")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@bike_club1).to be_an_instance_of(BikeClub)
    end

    it 'has a name' do
      expect(@bike_club1.name).to eq("Steve's Naughty Cats")
      expect(@bike_club2.name).to eq("Susan's Sweet kittens")
    end

    it 'has an empty array of bikers' do
      expect(@bike_club1.bikers).to eq([])
    end
  end

  describe '#add_biker' do
    it 'can add a biker' do
      @bike_club1.add_biker(@biker1)

      expect(@bike_club1.bikers).to eq([@biker1])
      expect(@bike_club2.bikers).to eq([])
    end

      it 'can add multiple bikers' do
        @bike_club1.add_biker(@biker1)
        @bike_club1.add_biker(@biker2)

        expect(@bike_club1.bikers).to eq([@biker1, @biker2])
      end
  end

end