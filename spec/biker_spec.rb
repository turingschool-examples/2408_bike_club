require "rspec"
require "./lib/ride"
require "./lib/biker"

RSpec.describe do
    before(:each) do

        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
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

    it 'can log rides' do
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)

        expected_rides = {
      @ride1 => [92.5, 91.1],
      @ride2 => [60.9, 61.6]
        }

    expect(@biker.rides).to eq(expected_rides)
    end

    it 'can return a personal record' do
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)


        expect(@biker.personal_record(@ride1)).to eq(91.1)
        expect(@biker.personal_record(@ride2)).to eq(60.9)
    end

    it 'can have another biker' do
        @biker2 = Biker.new("Athena", 15)

        expect(@biker2.rides).to eq({})
    end

    it 'can log rides correctly' do
        @biker2.log_ride(@ride1, 97.0)
        @biker.log_ride(@ride2, 67.0)

        expect(@biker2.rides).to eq({})
    end

    it 'can learn terrain' do
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2.log_ride(@ride1, 95.0)
        @biker2.log_ride(@ride2, 65.0)

        expect(@biker2.rides).to eq(@ride2)


    end
end
end
