require './lib/ride'
require './lib/biker'
require 'pry'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end
  
  describe '#initialize' do
    it' exists and has attributes' do
      expect(@biker).to be_instance_of(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  end
  
  describe '#learn_terrain!' do
    it 'allows biker to learn terrain' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe '#log_ride' do
    it 'logs rides and times for a ride' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.rides[@ride1]).to eq([92.5, 91.1])
      expect(@biker.rides[@ride2]).to eq([60.9, 61.6])
    end

    it 'doesnt log rides if the biker doesnt know terrain' do
      @biker2.log_ride(@ride1, 97.0)
      @biker2.log_ride(@ride2, 67.0)

      expect(@biker2.rides).to eq({})
    end

    it 'doesnt log a ride because of max distance' do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)

      expect(@biker2.rides[@ride1]).to be_nil
      expect(@biker2.rides[@ride2]).to eq([65])
    end
  end

  describe '#personal_record' do
    it 'shows min time for all rides done'do
    @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
    expect(@biker.personal_record(@ride1)).to eq(91.1)
    expect(@biker.personal_record(@ride2)).to eq(60.9)
    end

    it 'shows min times, only rides that rider can do' do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)

      expect(@biker2.personal_record(@ride1)).to eq (false)
      expect(@biker2.personal_record(@ride2)).to eq (65.0)
    end
  end
end