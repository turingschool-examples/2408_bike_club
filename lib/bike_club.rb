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

    def best_time(ride)
        return nil unless ride.is_a?(Ride)

        eligible_bikers = bikers_eligible(ride)
        return nil if eligible_bikers.empty?

        bikers_with_times = eligible_bikers.select {|biker| biker.rides[ride] && !biker.rides[ride].empty?}
        return nil if bikers_with_times.empty?

        eligible_bikers.min_by {|biker| biker.rides[ride].min}
    end
end