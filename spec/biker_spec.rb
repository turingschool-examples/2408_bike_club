require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    before(:each) do
        @biker = Biker.new("Kenny", 30) 
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

        it 'exists' do 
            expect(@biker).to be_an_instance_of(Biker)
            expect(@biker2).to be_an_instance_of(Biker)
            expect(@biker.name).to eq('Kenny')
            expect(@biker2.max_distance).to eq(15)
        end

        it 'can learn terrain' do 
            @biker2.learn_terrain(:gravel)
            @biker2.learn_terrain(:hills)

            expect(@biker2.acceptable_terrain).to eq([:gravel, :hills])
            expect(@biker.acceptable_terrain).to eq([])
        end

        it 'can log rides' do 
            @biker.learn_terrain(:gravel)
            @biker.learn_terrain(:hills)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride1, 97.9)

            expect(@biker.rides).to eq({@ride1 => [92.5], @ride2 => [61.6]})
            expect(@biker2.rides).to eq({})
        end
         
        it 'can have personal records' do 
            @biker.learn_terrain(:hills)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 88.0)

            expect(@biker.personal_record(@ride1)).to eq(88.0) 
            expect(@biker.personal_record(@ride2)).to eq false
        end
end