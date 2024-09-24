require 'spec_helper'
RSpec.describe Biker do 
    before(:each) do 
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
    end

    describe 'initialize' do 
        it 'exists' do
            expect(@biker1).to be_an_instance_of(Biker)
            expect(@biker2).to be_an_instance_of(Biker)
        end

        it 'has attributes' do
            expect(@biker1.name).to eq("Kenny")
            expect(@biker2.name).to eq("Athena")
            expect(@biker1.max_distance).to eq(30)
            expect(@biker2.max_distance).to eq(15)
            expect(@biker1.rides).to eq({})
            expect(@biker2.rides).to eq({})
        end
    end

    describe 'it can learn terrain' do
        it 'starts with no terrain' do
            expect(@biker1.acceptable_terrain).to eq([])
            expect(@biker2.acceptable_terrain).to eq([])
        end

        it 'can add terrain' do
            @biker1.learn_terrain!(:gravel)
            expect(@biker1.acceptable_terrain).to eq([:gravel])
            expect(@biker2.acceptable_terrain).to eq([])
            @biker1.learn_terrain!(:hills)
            expect(@biker1.acceptable_terrain).to eq([:gravel, :hills])
            expect(@biker2.acceptable_terrain).to eq([])
        end
    end

    describe 'it can log rides' do
        it 'starts with no rides' do
            expect(@biker1.rides).to eq({})
            expect(@biker2.rides).to eq({})
        end

        it 'can log rides' do 
            @biker1.learn_terrain!(:hills)
            @biker1.learn_terrain!(:gravel)
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 91.1)
            @biker1.log_ride(@ride2, 60.9)
            @biker1.log_ride(@ride2, 61.6)
            expect(@biker1.rides).to be_an_instance_of(Hash)
            expect(@biker1.rides.keys).to include(@ride1, @ride2)
            expect(@biker2.rides).to eq({})
        end

        it 'cant bike on unknown terrain' do
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 91.1)
            @biker1.log_ride(@ride2, 60.9)
            @biker1.log_ride(@ride2, 61.6)
            expect(@biker1.rides.keys).to_not include(@ride1, @ride2)
        end

        it 'cant bike further than max distance' do
            @biker2.learn_terrain!(:hills)
            @biker2.log_ride(@ride1, 92.5)
            expect(@biker2.rides).to eq({})
        end
    end

    describe 'personal records' do
        it 'can show personal records' do 
            @biker1.learn_terrain!(:hills)
            @biker1.learn_terrain!(:gravel)
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 92.5)
            @biker1.log_ride(@ride1, 91.1)
            @biker1.log_ride(@ride2, 60.9)
            @biker1.log_ride(@ride2, 61.6)
            expect(@biker1.personal_record(@ride1)).to eq(91.1)
            expect(@biker1.personal_record(@ride2)).to eq(60.9)
        end
    end
end