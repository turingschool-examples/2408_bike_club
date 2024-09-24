require './spec/spec_helper'

RSpec.describe BikeClub do
    before(:each) do
        @bikeclub_1 = BikeClub.new("Cohort 2408")
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
    end

    it 'can initialize and return variables' do
        expect(@bikeclub_1).to be_an_instance_of(BikeClub)
        expect(@bikeclub_1.name).to eq("Cohort 2408")
        expect(@bikeclub_1.bikers).to eq([])
    end

    it 'can add bikers to the club' do
        @bikeclub_1.add_biker(@biker)
        expect(@bikeclub_1.bikers.count).to eq(1)

        @bikeclub_1.add_biker(@biker2)
        expect(@bikeclub_1.bikers.count).to eq(2)
    end

    it 'can tell who has logged the most rides' do
        @bikeclub_1.add_biker(@biker)
        @bikeclub_1.add_biker(@biker2)

        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)

        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2.log_ride(@ride1, 95.0)
        @biker2.log_ride(@ride2, 65.0)
        
        expect(@bikeclub_1.most_rides).to eq(@biker)
    end

    it 'can tell who had the best time on a ride' do
        @bikeclub_1.add_biker(@biker)
        @bikeclub_1.add_biker(@biker2)

        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)

        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2.log_ride(@ride1, 95.0)
        @biker2.log_ride(@ride2, 65.0)
        
        expect(@bikeclub_1.best_time(@ride1)).to eq("Kenny")
        expect(@bikeclub_1.best_time(@ride2)).to eq("Kenny")
    end

    it 'can determine eligible riders' do
        @bikeclub_1.add_biker(@biker)
        @bikeclub_1.add_biker(@biker2)

        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)

        @biker2.learn_terrain!(:gravel)

        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

        expect(@bikeclub_1.bikers_eligible(@ride1)).to eq([@biker])
        expect(@bikeclub_1.bikers_eligible(@ride1)).to eq([@biker, @biker2])
    end
end