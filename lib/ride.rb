class Ride
    attr_reader :name, :distance, :loop, :terrain

    def initialize(attrs)
        @name = attrs[:name]
        @distance = attrs[:distance]
        @loop = attrs[:loop]
        @terrain = attrs[:terrain]
    end

    def loop?
        @loop
    end

    def total_distance
        @loop ? @distance : @distance * 2
    end
end