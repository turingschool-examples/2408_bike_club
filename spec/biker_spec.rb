require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    it 'exist' do
        biker = Biker.new("Kenny", 30)

        expect(biker.name).to eq("Kenny")
        expect(biker.max_distance).to eq(30)
        expect(biker.rides).to eq({})
        expect(biker.acceptable_terrain).to eq([])
    end

    it 'has a list of terrain and can learn terrain' do
        biker = Biker.new("Kenny", 30)

        expect(biker.acceptable_terrain).to eq([])

        biker.learn_terrain(:gravel)

        expect(biker.acceptable_terrain).to eq([:gravel])

        biker.learn_terrain(:hills)

        expect(biker.acceptable_terrain).to eq([:gravel, :hills])
    end

    it 'keeps a log of rides and times' do
        biker = Biker.new("Kenny", 30)
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        biker.learn_terrain(:gravel)
        biker.learn_terrain(:hills)

        biker.log_ride(ride1, 92.5)
        biker.log_ride(ride1, 91.1)
        biker.log_ride(ride2, 60.9)
        biker.log_ride(ride2, 61.6)

        expected = {
          ride1 => [92.5, 91.1],
          ride2 => [60.9, 61.6]
        }

        expect(biker.rides).to eq(expected)
    end

    it 'only logs a ride if the terrain and distance are acceptable' do
       # biker1 = Biker.new("Kenny", 30)
        biker2 = Biker.new("Athena", 15)
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        biker2.log_ride(ride1, 97.0)
        biker2.log_ride(ride2, 67.0)

        expect(biker2.rides).to eq({})

        biker2.learn_terrain(:gravel)
        biker2.learn_terrain(:hills)

        biker2.log_ride(ride1, 95.0)
        biker2.log_ride(ride2, 65.0)

        expect(biker2.rides).to eq({ride1 => [95.0], ride2 => [65.0]})
    end

    it 'finds the minimum time for a ride' do
        biker = Biker.new("Kenny", 30)
        biker2 = Biker.new("Athena", 15)
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        biker.learn_terrain(:gravel)
        biker.learn_terrain(:hills)

        biker.log_ride(ride1, 92.5)
        biker.log_ride(ride1, 91.1)
        biker.log_ride(ride2, 60.9)
        biker.log_ride(ride2, 61.6)

        expect(biker.personal_record(ride1, 91.1)).to eq(true)
        expect(biker.personal_record(ride2, 60.9)).to eq(true)
        expect(biker2.personal_record(ride1, 92.5)).to eq(false)
    end
end