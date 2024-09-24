require './lib/ride'

RSpec.describe Ride do
    it 'exist' do
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})

        expect(ride1.name).to eq("Walnut Creek Trail")
        expect(ride1.distance).to eq(10.7)
        expect(ride1.loop?).to eq(false)
        expect(ride1.terrain).to eq(:hills)
    end

    it 'can tell if it is a loop or not' do
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        expect(ride1.loop?).to eq(false)
        expect(ride2.loop?).to eq(true)
    end

    it 'cals the total distance' do
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        expect(ride2.total_distance).to eq(14.9)
        expect(ride1.total_distance).to eq(21.4)
    end
end