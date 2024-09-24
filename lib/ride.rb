class Ride
    attr_reader :name,
                :distance,
                :loop,
                :terrain

    def initialize (info)
        @name = info[:name]
        @distance = info[:distance]
        @loop = info[:loop]
        @terrain = info[:terrain]
    end

    def loop?
        if @loop == true
            true
        else
            false
        end
    end

    def total_distance
        if loop? == true
            total_distance = @distance
        else
            total_distance = (@distance * 2)
        end
    end
end