class Biker
    attr_reader :name, :max_distance

    attr_accessor :acceptable_terrain, :rides

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @acceptable_terrain = []
        @rides = {}
    end

    def log_ride (ride, time)
        if @acceptable_terrain.include?(ride.terrain) && ride.distance <= @max_distance
            rides[ride] ||= [] #makes an array for the ride
            rides[ride] << time #put in time to the array for that specific ridw
        end
    end

    def learn_terrain(terrain)
        @acceptable_terrain << terrain
    end

    def personal_record(ride)

        if @rides.key?(ride)
          @rides[ride].min #smallest time
        else
          false 
        end
    end
end