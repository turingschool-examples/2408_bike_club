require "rspec"
require "./lib/ride"
require "./lib/biker"

RSpec.describe do
    before(:each) do

        @biker = Biker.new("Kenny", 30)
    end

describe '#biker' do
    it 'be an instance of' do

        expect(@biker).to be_an_instance_of(Biker)
    end

    it 'can return a name' do

        expect(@biker.name).to eq("Kenny")
    end
end
end