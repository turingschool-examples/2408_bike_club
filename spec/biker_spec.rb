require "rspec"
require "./lib/ride"
require "./lib/biker"

RSpec.describe do
    before(:each) do

        @biker = Biker.new("Kenny", 30)
    end

describe '#biker' do
    it 'be an instance of' do

        expect(@biker).to be_an_instance_of(Biker)
    end

    it 'can return a name' do

        expect(@biker.name).to eq("Kenny")
    end

    it 'can return the bikers max distance' do

        expect(@biker.max_distance).to eq(30)
    end

    it 'starts with an empty hash of rides' do

        expect(@biker.rides).to eq({})
    end

    it 'starts with an empty array of acceptable terrain' do

        expect(@biker.acceptable_terrain).to eq([])
    end

    it 'can learn terrains' do
        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)

        expect(@biker.acceptable_terrain).to eq ([:gravel, :hills])
    end
end
end
