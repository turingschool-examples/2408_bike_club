require 'spec_helper'
RSpec.describe Ride do 
    before(:each) do
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    describe 'initialize' do
        it 'exists' do 
            expect(@ride1).to be_an_instance_of(Ride)
        end
    

        it 'has attributes' do 
            expect(@ride1.name).to eq("Walnut Creek Trail")
            expect(@ride1.distance).to eq(10.7)
            expect(@ride1.terrain).to eq(:hills)
            expect(@ride1.loop?).to eq(false)
            expect(@ride1.total_diatance).to eq(21.4)
        end

        it 'can be a loop' do 
            expect(@ride2.loop).to eq(true)
            expect(@ride2.distance).to eq(14.9)
            expect(@ride2.total_diatance).to eq(14.9)
        end
    end
end