require './lib/biker'
require 'pry'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
  end
  
    it' exists and has attributes' do
      expect(@biker).to be_instance_of(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  
  describe '#learn_terrain!' do
    it 'allows biker to learn terrain' do
      (@biker.learn_terrain!(:gravel))
      (@biker.learn_terrain!(:hills))
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end
end