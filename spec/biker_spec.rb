require './lib/ride'
require './lib/biker' 

RSpec.describe Biker do
    before(:each) do
      @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
      @biker = Biker.new("Kenny", 30)
      @biker2 = Biker.new("Athena", 15)
    end
  
    it 'exists' do
      expect(@biker).to be_an_instance_of(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  
    it 'can learn terrain' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      
      expect(@biker.acceptable_terrain).to include(:gravel, :hills)
    end
  
    it 'can log rides' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
  
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      
      expect(@biker.rides).to eq({@ride1 => [92.5, 91.1], @ride2 => [60.9, 61.6]})
    end
  
    it 'can log personal records' do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
  
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
  
      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)
    end
  
    it 'does not log rides before learning terrain' do
      expect(@biker2.rides).to eq({})
  
      expect {
        @biker2.log_ride(@ride1, 97.0)
      }.to raise_error("You need to learn this terrain to ride Walnut Creek Trail.")
      
      expect(@biker2.rides).to eq({})
    end
  
    it 'can log rides after learning terrain' do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
  
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)
  
      expect(@biker2.rides).to eq({@ride1 => [95.0], @ride2 => [65.0]})
    end
  
    it 'can record personal records after learning terrain' do
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
  
      @biker2.log_ride(@ride2, 65.0)
  
      expect(@biker2.personal_record(@ride2)).to eq(65.0)
      expect(@biker2.personal_record(@ride1)).to eq(false)
    end
  end