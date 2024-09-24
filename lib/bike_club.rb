class BikeClub
    attr_reader :name, :bikers

    def initialize(name)
        @name = name
        @bikers = []
    end

    def add_biker(biker)
        @bikers << biker unless @bikers.include?(biker)
    end

    def most_rides
        @bikers.max_by {|biker| biker.rides.values.flatten.count}
    end

    def learn_terrain(terrain)
        @bikers.each { |biker| biker.learn_terrain(terrain) }
    end

    def bikers_eligible(ride)
        return [] unless ride && ride.is_a?(Ride)
        @bikers.select do |biker|
            biker.acceptable_terrain.include?(ride.terrain) && biker.max_distance >= ride.distance
        end
    end
end