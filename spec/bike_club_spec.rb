require './spec/spec_helper'

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Cyclovia")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe 'bikeclub' do
    it 'has a cool name' do
      expect(@club.name).to eq("Cyclovia")
    end

    it 'begins without bikers' do
      expect(@club.bikers).to eq([])
    end
  end

  describe 'add biker' do
    it 'can add bikers' do
      @club.add_biker(@biker1)
      expect(@club.bikers).to eq([@biker1])
      @club.add_biker(@biker2)
      expect(@club.bikers).to eq([@biker1, @biker2])
    end
  end

  describe 'most rides' do
    it 'knows which biker has the most rides' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @biker1.learn_terrain!(:hills)
      @biker2.learn_terrain!(:hills)
      @biker1.log_ride(@ride1, 90)
      @biker1.log_ride(@ride1, 88)
      @biker2.log_ride(@ride1, 85)
      expect(@club.most_rides).to eq(@biker1)
    end
  end

  describe 'best time' do
    it 'knows who has the best time on a ride' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @biker1.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:gravel)     
      @biker1.log_ride(@ride2, 90)
      @biker1.log_ride(@ride2, 88)
      @biker2.log_ride(@ride2, 85)
      expect(@club.best_time(@ride2)).to eq(@biker2)
    end
  end

  describe 'bikers eligible' do 
    it 'knows which bikers are eligible for a ride' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @biker1.learn_terrain!(:hills)
      expect(@club.bikers_eligible(@ride1)).to eq([@biker1])
    end
  end

  describe 'record group ride' do
    before(:each) do
      @biker3 = Biker.new("Himanshu", 4)      
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)
      @biker1.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:gravel)
      @biker3.learn_terrain!(:grave)
    end
    it 'records group ride with start time for eligible members' do
      expect(@club.group_rides).to eq([])

      allow(Date).to receive(:today).and_return(Date.new(2005, 10, 31))
      allow(Time).to receive(:now).and_return(Time.new(2005, 10, 31, 8, 00, 30))

      finish = @club.record_group_ride(@ride2)
      expect(finish[:start_time].strftime("%m/%d/%Y %H:%M:%S")).to eq("10/31/2005 08:00:30")
      expect(finish[:ride]).to eq(@ride2)
      expect(finish[:members]).to eq([@biker1, @biker2])
      expect(finish[:members].include?(@biker3)).to eq(false)
    end
  end

  describe 'finish ride' do
    before(:each) do
      @biker3 = Biker.new("Himanshu", 19)      
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)
      @biker1.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:gravel)
      @biker3.learn_terrain!(:gravel)
    end
    it 'logs ride times for individual bikers' do
      allow(Time).to receive(:now).and_return(Time.new(2005, 10, 31, 8, 00, 30))
      @club.record_group_ride(@ride2)
      allow(Time).to receive(:now).and_return(Time.new(2005, 10, 31, 9, 04, 33))
      @club.finish_ride(@biker2)
      allow(Time).to receive(:now).and_return(Time.new(2005, 10, 31, 9, 15, 44))
      @club.finish_ride(@biker1)
      allow(Time).to receive(:now).and_return(Time.new(2005, 10, 31, 9, 36, 42))
      @club.finish_ride(@biker3)

      expect(@biker1.rides[@ride2]).to eq([75])
      expect(@biker2.rides[@ride2]).to eq([64])
      expect(@biker3.rides[@ride2]).to eq([96])
    end
  end
end