require 'pry'
require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    before(:each) do
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

    end

    describe 'initalize' do
        it 'can iniitalize' do
            expect(@biker).to be_an_instance_of(Biker)
        end

        it 'has attributes' do
            expect(@biker.name).to eq("Kenny")
            expect(@biker.max_distance).to eq(30)
            expect(@biker.rides).to eq({})
            expect(@biker.acceptable_terrain).to eq([])
        end
    end

    describe '#learn_terrain!' do
        it 'can learn new terrain' do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
            expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
        end
    end

    describe '#log_ride' do
        it 'can log rides' do
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)

            rides_hash = {
                        <Ride:0x00007fc62ca32a10...> => [92.5, 91.1],
                        <Ride:0x00007fc62cb42ba8...> => [60.9, 61.6]
                         }

            expect(@biker.rides).to eq(rides_hash)
        end

        it 'can determine personal records by ride' do
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
        
            expect(@biker.personal_record(@ride1)).to eq (91.1)
            expect(@biker.personal_record(@ride2)).to eq (60.9)
        end

        it 'only logs rides if they know the terrain' do
            @biker2.log_ride(@ride1, 97.0)
            @biker2.log_ride(@ride2, 67.0)
            expect(@biker2.rides).to eq({})
        end

        it 'only logs rides if they can bike the distance' do
            @biker2.learn_terrain!(:gravel)
            @biker2.learn_terrain!(:hills)
            @biker2.log_ride(@ride1, 95.0)
            @biker2.log_ride(@ride2, 65.0)

            expect(@biker2.acceptable_terrain).to eq([:gravel, :hills])
            expect(@biker2.rides).to eq({@ride2: [65.0]})
        end

    end
end