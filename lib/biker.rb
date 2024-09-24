class Biker
    attr_reader :name, :max_distance, :rides, :acceptable_terrain

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = {}
        @acceptable_terrain = []
    end

    def learn_terrain(terrain)
        @acceptable_terrain << terrain unless @acceptable_terrain.include?(terrain)
    end

    def log_ride(ride, time)
        return unless ride

        if @acceptable_terrain.include?(ride.terrain) && ride.distance <= @max_distance
            if @rides[ride]
                @rides[ride] << time
            else
                @rides[ride] = [time]
            end
        end
    end

    def personal_record(ride, time)
    times = @rides[ride]

    return false unless times
        if times << times.min
            @rides[ride] << time
            true
        else
            false
        end
    end
end