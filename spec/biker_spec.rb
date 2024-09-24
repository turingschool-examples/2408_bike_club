require './spec/spec_helper'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe 'biker' do
    it 'has attributes' do
      expect(@biker).to be_an_instance_of(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe 'learn terrain' do
    it 'can learn new terrain' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe 'log rides' do
    it 'can store ride data' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      test_rides = {
        @ride1 => [92.5, 91.1],
        @ride2 => [60.9, 61.6]
      }
      expect(@biker.rides).to eq(test_rides)      
    end
  end

  describe 'pr' do
    it 'can store best ride time' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)
    
    end
  end

  describe 'can do rides' do
    it 'cannot do all rides depending on skill' do    
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 95.0)
      expect(@biker2.rides).to eq({})
      @biker2.log_ride(@ride2, 65.0)
      expect(@biker2.rides).to eq({})
      @biker2.learn_terrain!(:gravel)
      @biker2.log_ride(@ride2, 65.0)
      expect(@biker2.rides).to eq({ @ride2 => [65.0]})
      expect(@biker2.personal_record(@ride2)).to eq(65.0)
      expect(@biker2.personal_record(@ride1)).to be false
    end
  end      
end