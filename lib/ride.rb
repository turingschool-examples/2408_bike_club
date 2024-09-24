class Ride
    attr_reader :name, :distance, :terrain
    def initialize(info)
        @name = info[:name]
        @distance = info[:distance]
        @terrain = info[:terrain]
        @is_loop = info[:loop]
    end

    def loop?
        @is_loop
    end


end