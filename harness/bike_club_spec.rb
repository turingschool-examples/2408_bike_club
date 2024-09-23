require './harness/spec_helper'

RSpec.describe "Bike Club" do
  before :each do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end
  describe 'Iteration 1' do
    describe '1. #initialize' do
      it 'creates rides with attributes' do
        expect(Ride).to respond_to(:new).with(1).argument
        expect(@ride1).to be_a(Ride)
        expect(@ride1.name).to eq("Walnut Creek Trail")
        expect(@ride1.distance).to eq(10.7)
        expect(@ride1.terrain).to eq(:hills)
      end
    end

    describe '2. #loop?' do
      it 'can tell if it is a loop or not' do
        expect(@ride1.loop?).to eq(false)
        expect(@ride2.loop?).to eq(true)
      end
    end

    describe '3. #total_distance' do
      it 'returns the correct distance based on whether or not the trail is a loop' do
        expect(@ride2.total_distance).to eq(14.9)
        expect(@ride1.total_distance).to eq(21.4)
      end
    end
  end

  describe 'Iteration 2' do
    before :each do
      @biker = Biker.new("Kenny", 30)
      @biker2 = Biker.new("Athena", 15)
    end
    describe '4. #initialize' do
      it 'creates a biker with attributes' do
        expect(@biker).to be_a(Biker)
        expect(@biker.name).to eq("Kenny")
        expect(@biker.max_distance).to eq(30)
      end
    end

    describe '5. #acceptable_terrain and #learn_terrain!' do
      it 'has a list of terrain and can learn terrain' do
        expect(@biker.acceptable_terrain).to eq([])
        @biker.learn_terrain!(:gravel)
        expect(@biker.acceptable_terrain).to eq([:gravel])
        @biker.learn_terrain!(:hills)
        expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
      end
    end

    describe '6. #log_ride' do
      it 'keeps a log of rides and times' do

        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)
        expected = {
          @ride1 => [92.5, 91.1],
          @ride2 => [60.9, 61.6]
        }
        expect(@biker.rides).to eq(expected)
      end
    end

    describe '7. #log_ride' do
      it 'only logs a ride if the terrain and distance are acceptable' do
        @biker2.log_ride(@ride1, 97.0)
        @biker2.log_ride(@ride2, 67.0)
        expect(@biker2.rides).to eq({})
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker2.log_ride(@ride1, 95.0)
        @biker2.log_ride(@ride2, 65.0)
        expect(@biker2.rides).to eq({@ride2 => [65.0]})
      end
    end

    describe '8. #personal_record' do
      it 'finds the minimum time for a ride' do
        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)
        expect(@biker.personal_record(@ride1)).to eq(91.1)
        expect(@biker.personal_record(@ride2)).to eq(60.9)
        expect(@biker2.personal_record(@ride1)).to eq(false)
      end
    end
  end

  describe 'Iteration 3' do
    before :each do
      @biker1 = Biker.new("Kenny", 30)
      @biker2 = Biker.new("Athena", 15)
      @bike_club = BikeClub.new("Twin City Terrors")
    end
    describe '9. #initialize' do
      it 'creates a bike club with attributes' do
        expect(@bike_club).to be_a(BikeClub)
        expect(@bike_club.name).to eq("Twin City Terrors")
        expect(@bike_club.bikers).to eq([])
      end
    end
    describe '10. #add_bikers' do
      it 'can add bikers' do
        expect(@bike_club.bikers).to eq([])
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        expect(@bike_club.bikers).to eq([@biker1, @biker2])
      end
    end
    describe '11. #most_rides' do
      it 'can determine who has biked the most rides' do
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 6, loop: false, terrain: :hills})
        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker1.log_ride(@ride1, 92.5)
        @biker1.log_ride(@ride1, 91.1)
        @biker1.log_ride(@ride2, 60.9)
        @biker1.log_ride(@ride2, 61.6)
        @biker2.log_ride(@ride1, 90.3)
        @biker2.log_ride(@ride2, 61.9)
        @biker2.log_ride(@ride2, 62.6)
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        expect(@bike_club.most_rides).to eq(@biker1)
      end
    end
    describe '12. #best_time(ride)' do
      it 'can determine who has the best time for a ride' do
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 6, loop: false, terrain: :hills})
        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker1.log_ride(@ride1, 92.5)
        @biker1.log_ride(@ride1, 91.1)
        @biker1.log_ride(@ride2, 60.9)
        @biker1.log_ride(@ride2, 61.6)
        @biker2.log_ride(@ride1, 90.3)
        @biker2.log_ride(@ride2, 61.9)
        @biker2.log_ride(@ride2, 62.6)
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        expect(@bike_club.best_time(@ride1)).to eq(@biker2)
        expect(@bike_club.best_time(@ride2)).to eq(@biker1)
      end
    end
    describe '13. #bikers_eligible(ride)' do
      it 'can determine who has the best time for a ride' do
        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @bike_club.add_biker(@biker1)
        @bike_club.add_biker(@biker2)
        expect(@bike_club.bikers_eligible(@ride1)).to eq([@biker1])
        expect(@bike_club.bikers_eligible(@ride2)).to eq([@biker1, @biker2])
      end
    end
  end
  describe 'Iteration 4' do
    before :each do
      @biker1 = Biker.new("Kenny", 30)
      @biker2 = Biker.new("Athena", 15)
      @bike_club = BikeClub.new("Twin City Terrors")
      @biker1.learn_terrain!(:gravel)
      @biker1.learn_terrain!(:hills)
      @biker2.learn_terrain!(:gravel)
      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)
    end
    describe '14. #record_group_ride' do
      it 'can record a group ride' do
        start_time = Time.now - 5400 # 90 min ago
        allow(@bike_club).to receive(:log_time).and_return(start_time)
        expected1 = {
          start_time: start_time,
          bikers: [@biker1, @biker2]
        }

        expect(@bike_club.record_group_ride(@ride2)).to eq(expected1)
        allow(@bike_club).to receive(:log_time).and_return(Time.now - 600) # biker1 end time, 80 min later
        @bike_club.finish_group_ride(@ride2, @biker1, start_time)
        expect(@biker1.rides[@ride2]).to eq([80])

        allow(@bike_club).to receive(:log_time).and_return(Time.now) # biker2 end time, 90 min later
        @bike_club.finish_group_ride(@ride2, @biker2, start_time)
        expect(@biker2.rides[@ride2]).to eq([90])
      end
    end
    describe '15. .best_time(ride)' do
      before(:each) do
        BikeClub.clear_all
        @biker1 = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 32)
        @biker3 = Biker.new("Bruce", 40)
        @biker4 = Biker.new("Penny", 35)
        @biker5 = Biker.new("Athena", 45)
        @bike_club1 = BikeClub.new("Twin City Team")
        @bike_club2 = BikeClub.new("Denver Delights")
        @biker1.learn_terrain!(:gravel)
        @biker1.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @biker2.learn_terrain!(:hills)
        @biker3.learn_terrain!(:gravel)
        @biker3.learn_terrain!(:hills)
        @biker4.learn_terrain!(:gravel)
        @biker4.learn_terrain!(:hills)
        @biker5.learn_terrain!(:gravel)
        @biker5.learn_terrain!(:hills)
        @bike_club1.add_biker(@biker1)
        @bike_club1.add_biker(@biker2)
        @bike_club1.add_biker(@biker3)
        @bike_club2.add_biker(@biker3)
        @bike_club2.add_biker(@biker4)
        @bike_club2.add_biker(@biker5)
        @biker1.log_ride(@ride1, 92.5)
        @biker1.log_ride(@ride1, 91.1)
        @biker1.log_ride(@ride2, 60.9)
        @biker1.log_ride(@ride2, 61.6)
        @biker2.log_ride(@ride1, 90.3) #ride 1 best of club 1 not of all clubs
        @biker2.log_ride(@ride2, 59.8) #ride 2 best rider; club 1
        @biker3.log_ride(@ride2, 63.6)
        @biker3.log_ride(@ride2, 69.6)
        @biker4.log_ride(@ride2, 65.6)
        @biker4.log_ride(@ride1, 89.6) #ride 1 best rider; club 2
        @biker5.log_ride(@ride2, 60.6) #ride 2 best of club 2 not of all clubs
        @biker5.log_ride(@ride2, 67.6)
      end
      it 'returns best time for a ride of all bikers in all clubs' do
        expect(BikeClub.best_time(@ride1)).to eq(@biker4)
        expect(BikeClub.best_time(@ride2)).to eq(@biker2)
      end
    end
  end
end
