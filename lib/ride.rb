class Ride
    attr_reader :name, :distance, :terrain
    def initialize(info)
        @name = info[:name]
        @distance = info[:distance]
        @terrain = info[:terrain]
        @loop = info[:loop]
    end
end