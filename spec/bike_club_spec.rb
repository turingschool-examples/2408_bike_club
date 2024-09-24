require './spec/spec_helper'

RSpec.describe BikeClub do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15) #cannot do route 1
    @bike_club1 = BikeClub.new("Steve's Naughty Cats")
    @bike_club2 = BikeClub.new("Susan's Sweet kittens")
    @biker1.learn_terrain!(:hills)
    @biker2.learn_terrain!(:hills)
    @biker1.learn_terrain!(:gravel)
    @biker2.learn_terrain!(:gravel)
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

  describe '#most_rides' do
    it 'show which biker has the most rides total' do
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker2)

      @biker1.log_ride(@ride1, 90.2)
      @biker1.log_ride(@ride1, 89.2)
      @biker2.log_ride(@ride2, 65.2)
      @biker2.log_ride(@ride2, 62.2)
      @biker2.log_ride(@ride2, 60.2)


      expect(@bike_club1.most_rides).to eq(@biker2)
    end
  end

  describe '#best_time' do

    it 'shows which biker has best time for a given ride' do
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker2)

      @biker1.log_ride(@ride2, 67.3)
      @biker1.log_ride(@ride2, 65.2)
      @biker1.log_ride(@ride2, 64.1)

      @biker2.log_ride(@ride2, 66.2)
      @biker2.log_ride(@ride2, 63.2)

      expect(@bike_club1.best_time(@ride2)).to eq(@biker2)
    end
  end

  describe '#eligible' do
    it 'show which riders are eligible for a ride' do
      @bike_club1.add_biker(@biker1)
      @bike_club1.add_biker(@biker2)

      expect(@bike_club1.eligible(@ride1)).to eq([@biker1])

      expect(@bike_club1.eligible(@ride2)).to eq([@biker1, @biker2])
    end
  end

end