require './lib/ride'

RSpec.describe Ride do 
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
  end
    it ' exists and has attributes' do
    expect(@ride1).to be_instance_of(Ride)
    expect(@ride1.name).to eq("Walnut Creek Trail")
    expect(@ride1.distance).to eq(10.7)
    expect(@ride1.loop?).to eq(false)
    expect(@ride1.terrain).to eq(:hills)
  end
end
