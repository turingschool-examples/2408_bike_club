require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    before(:each) do
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) 
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    describe '#initialize' do
        it "exists" do
            expect(@biker).to be_instance_of(Biker)
        end

        it 'has attributes' do
            expect(@biker.name).to eq("Kenny")
            expect(@biker.max_distance).to eq(30)
            expect(@biker2.name).to eq("Athena")
            expect(@biker2.max_distance).to eq(15)
        end
    end

    describe '#rides' do
        it 'begins with an empty hash of rides' do
            expect(@biker.rides).to eq({})
        end
    end

    describe '#terrain' do
        it 'has acceptable terrain' do
            expect(@biker.acceptable_terrain).to eq([])
        end

        it 'can learn terrain' do
            @biker.learn_terrain!(:gravel)

            expect(@biker.acceptable_terrain).to eq([:gravel])
        end

        it 'can learn multiple terrains' do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)

            expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
        end
    end

    describe '#logging rides' do
        before(:each) do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills}) 
            @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        end

        it 'can log rides' do
            @biker.log_ride(@ride1, 92.5)
            
            expect(@biker.rides).to eq({})
        end

        it 'will not log a ride if the biker has not learned the terrain' do
            # require 'pry';binding.pry
            expect(@biker2.log_ride(@ride1, 97.0)).to eq(false)
            expect(@biker2.log_ride(@ride2, 67.0)).to eq(false)
            expect(@biker2.rides).to eq({})
        end

        it 'logs rides once a biker has learned the terrain' do
            @biker2.learn_terrain!(:gravel)
            @biker2.learn_terrain!(:hills)
            @biker2.log_ride(@ride2, 67.0)

            expect(@biker2.rides).to eq({@ride2 => [67.0]})
        end

        it 'can log multiple rides' do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)

            expect(@biker.rides).to include(@ride1)
            expect(@biker.rides[@ride1].length).to eq(2)
        end

        it 'does not log rides if they exceed a bikers max distance' do
            @biker2.learn_terrain!(:gravel)
            @biker2.log_ride(@ride2, 65.0)

            expect(@biker2.log_ride(@ride1, 95.0)).to eq(false)
            expect(@biker2.rides[@ride2].length).to eq(1)
        end

    end

    describe '#timing rides' do
        before(:each) do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
        end

        it 'identifies a bikers personal record' do
        @biker.log_ride(@ride1, 92.5)

        expect(@biker.personal_record(@ride1)).to eq(92.5)
        end

        it 'updates the bikers personal record' do
        @biker.log_ride(@ride1, 91.1)

        expect(@biker.personal_record(@ride1)).to eq(91.1)
        end
    end
end
