# require 'pry'
# binding.pry
require './lib/ride'

RSpec.describe Ride do
    before(:each) do
      
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    it 'exists' do
        expect(@ride1).to be_an_instance_of(Ride)
        expect(@ride2).to be_an_instance_of(Ride)
    end

    it 'has info' do 
        expect(@ride1.distance).to eq(10.7)
        expect(@ride1.terrain).to eq(:hills)
        expect(@ride1.loop?).to be(false)
        expect(@ride1.total_distance).to eq(21.4)

        expect(@ride2.loop?).to be(true)
        expect(@ride2.distance).to eq(14.9)
    end


end