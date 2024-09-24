require "rspec"
require "./lib/ride"
require "./lib/biker"

RSpec.describe do
    before(:each) do

        @biker = Biker.new("Kenny", 30)
    end

describe '#ride' do
    it 'be an instance of' do

        expect(@biker).to be_an_instance_of(Biker)
    end
end
end