requre 'spec_helper'
Rspec.describe Ride do 
    before(:each) do
        ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    end

    describe 'initialize' do
        it 'exists' do 
            expect(ride1).to be_an_instance_of(Ride)
        end
    

        it 'has attributes' do 
            expect(ride1.name).to eq("Walnit Creek Trail")
            expect(ride1.distance).to eq(10.7)
            expect(ride1.terrain).to eq(:hills)
            expect(ride1.loop?).to eq(false)
            expect(ride1.total_diatance).to eq(21.4)
        end
    end
end