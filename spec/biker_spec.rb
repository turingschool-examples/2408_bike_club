require './spec/spec_helper'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)

  end

  describe 'biker' do
    it 'has attributes' do
      expect(@biker).to be_an_instance_of(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq([])
      expect(@biker.acceptable_terrain).to eq([])
    end
  end
end