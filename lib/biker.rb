class Biker
    attr_reader :name,
                :max_distance,
                :rides,
                :acceptable_terrain

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = Hash.new { |ride, time| ride[time] = [] }
        @acceptable_terrain = []
    end

    def learn_terrain!(terrain)
        @acceptable_terrain << terrain
    end

    def log_ride(ride, time)
        if @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
            @rides[ride] << time
        end
    end

    def personal_record(ride)
        @rides[ride].min
    end
end