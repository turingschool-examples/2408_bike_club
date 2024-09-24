require './spec/spec_helper'

RSpec.describe Biker do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@biker1).to be_an_instance_of(Biker)
      expect(@biker2).to be_an_instance_of(Biker)
    end

    it 'has name' do
      expect(@biker1.name).to eq("Kenny")
      expect(@biker2.name).to eq("Athena")
    end

    it 'has a max_distance' do
      expect(@biker1.max_distance).to eq(30)
      expect(@biker2.max_distance).to eq(15)
    end

    it 'has an empty hash of rides' do
      expect(@biker1.rides).to eq({})
      expect(@biker2.rides).to eq({})
    end

    it 'has empty list of acceptable_terrain' do
      expect(@biker1.acceptable_terrain).to eq([])
      expect(@biker2.acceptable_terrain).to eq([])
    end
  end

  describe '#learn_terrain!' do
    it 'can learn terrain' do
      expect(@biker1.acceptable_terrain).to eq([])
      expect(@biker2.acceptable_terrain).to eq([])

      @biker1.learn_terrain!(:gravel)
      expect(@biker1.acceptable_terrain).to eq([:gravel])
      expect(@biker2.acceptable_terrain).to eq([])

      @biker1.learn_terrain!(:hills)
      expect(@biker1.acceptable_terrain).to eq([:gravel, :hills])
      expect(@biker2.acceptable_terrain).to eq([])
    end
  end

  describe '#log_ride' do

    it 'wont log a ride if biker did not learn terrain' do
      @biker1.log_ride(@ride1, 92.5)
      expect(@biker1.rides).to eq({})
    end

    it 'wont ride if the total_disctance is bigger than max distance' do
      @biker2.learn_terrain!(:hills)
      @biker2.log_ride(@ride1, 92.5)

      expect(@biker2.rides).to eq({})

    end

    it 'can log rides with time' do
      @biker1.learn_terrain!(:hills)
      @biker1.log_ride(@ride1, 92.5)

      expect(@biker1.rides).to eq({@ride1 => [92.5]})
      expect(@biker2.rides).to eq({})
    end

    it 'can log multiple of the same ride' do
      @biker1.learn_terrain!(:hills)
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 91.2)

      expect(@biker1.rides).to eq({@ride1 => [92.5, 91.2]})
    end

    it 'can log different rides' do
      @biker1.learn_terrain!(:hills)
      @biker1.learn_terrain!(:gravel)

      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride2, 60.9)

      expect(@biker1.rides).to eq({@ride1 =>[92.5], @ride2 =>[60.9]})
      expect(@biker2.rides).to eq({})
    end
  end

  describe '#personal_record' do
    it 'can report a personal record' do
      @biker1.learn_terrain!(:hills)
      @biker1.log_ride(@ride1, 92.5)

      expect(@biker1.personal_record(@ride1)).to eq(92.5)

      @biker1.log_ride(@ride1, 91.2)

      expect(@biker1.personal_record(@ride1)).to eq(91.2)
    end

    it 'returns false if rider hasn"t done that ride' do
      @biker1.learn_terrain!(:hills)
      expect(@biker1.personal_record(@ride1)).to eq(false)

      @biker1.log_ride(@ride1, 92.5)
      expect(@biker1.personal_record(@ride1)).to eq(92.5)
    end
  end
end