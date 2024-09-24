require './lib/bike_club'
require './lib/ride'
require './lib/biker'

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Bike Gang")
  end

  describe '#initialize' do
    it 'exists with attributes' do
      expect(@club).to be_a(BikeClub)
      expect(@club.name).to eq("Bike Gang")
      expect(@club.bikers).to eq([])
    end
  end
end