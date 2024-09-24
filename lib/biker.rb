class Biker
    attr_reader :name,
                :max_distance,
                :rides,
                :acceptable_terrain

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = {}
        @acceptable_terrain = []
    end

    def learn_terrain!(terrain)
        @acceptable_terrain << terrain unless @acceptable_terrain.include?(terrain)
    end

    def log_ride(ride, time)
        return false unless @acceptable_terrain.include?(ride.terrain)
        return false unless ride.distance <= max_distance

        if @rides.key?(ride)
            @rides[ride] << [time]
        else
            @rides[ride] = [time]
        end
    end

    def personal_record(ride)
        return false unless @rides.key?(ride)

        @rides[ride].min
    end

end