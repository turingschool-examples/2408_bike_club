require './lib/bike_club'
require './lib/ride'
require './lib/biker'

RSpec.describe BikeClub do
  before(:each) do
    @bikeclub1 = BikeClub.new('BikeClub1')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@bikeclub1).to be_an_instance_of(BikeClub)
      expect(@bikeclub1.name).to eq('BikeClub1')
      expect(@bikeclub1.bikers).to eq([])
    end
  end
end