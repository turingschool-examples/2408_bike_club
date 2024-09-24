require './lib/bike_club'
require './lib/ride'
require './lib/biker'

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Bike Gang")
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe '#initialize' do
    it 'exists with attributes' do
      expect(@club).to be_a(BikeClub)
      expect(@club.name).to eq("Bike Gang")
      expect(@club.bikers).to eq([])
    end
  end

  describe '#add_biker' do
    it 'adds biker into bikers array' do
      @club.add_biker(@biker)
      @club.add_biker(@biker2)

      expect(@club.bikers).to eq([@biker, @biker2])
    end
  end

  describe '#most_rides' do
    it 'can find the biker with the most rides' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)

      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)

      @club.add_biker(@biker)
      @club.add_biker(@biker2)

      expect(@club.most_rides).to eq(@biker)
    end
  end

  describe '#best_time' do
    it ' can find the biker with the best time on a ride' do
      @biker.learn_terrain!(:gravel)
      @biker.log_ride(@ride2, 60.9)

      @biker2.learn_terrain!(:gravel)
      @biker2.log_ride(@ride2, 65.0)

      @club.add_biker(@biker)
      @club.add_biker(@biker2)

      expect(@club.best_time(@ride2)).to eq(@biker)
    end
  end

  describe '#bikers_eligible' do
    it 'finds bikers eligible to ride a ride by terrain' do
      @biker.learn_terrain!(:hills)
      @biker2.learn_terrain!(:gravel)

      @club.add_biker(@biker)
      @club.add_biker(@biker2)

      expect(@club.bikers_eligible(@ride2)).to eq([@biker2])
    end
  end

  describe '#record_group_ride' do
    it 'records a group ride' do
      @biker.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:gravel)

      @club.add_biker(@biker)
      @club.add_biker(@biker2)

      start_time = Time.now
      allow(Time).to receive(:now).and_return(start_time)

      result = (@club.record_group_ride(@ride2))     

      expect(result).to be_a(Hash)
      expect(result[:start_time]).to eq(start_time)
      expect(result[:ride]).to eq(@ride2)
      expect(result[:members]).to include(@biker, @biker2)

      expect(@club.group_rides).to include(result)
    end
  end

  describe '#finish_ride' do
    it 'logs each bikers fininsh time and calculates ride time' do
      @biker.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:gravel)

      @club.add_biker(@biker)
      @club.add_biker(@biker2)
      
      start_time = Time.now
      allow(Time).to receive(:now).and_return(start_time)

      @club.record_group_ride(@ride2)

      finish_time = start_time + 30 * 60
      allow(Time).to receive(:now).and_return(finish_time)

      @club.finish_ride(@biker)

      expected_duration = (finish_time - start_time) / 60

      expect(@biker.rides(@ride2)).to eq(expected duration)
    end
  end
end