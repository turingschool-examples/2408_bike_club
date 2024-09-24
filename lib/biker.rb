class Biker
    attr_reader :name, :max_distance, :rides, :acceptable_terrain
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
       if can_ride?(ride)
        @rides[ride] ||=[]
        @rides[ride] << time
        true
       else
        false
       end
    end

    def personal_record(ride)
       return false unless @rides.key?(ride) && !@rides[ride].empty?
        @rides[ride].compact.min
    end

    def can_ride?(ride)
        @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
    end
end