class Biker

    attr_reader :name, :max_distance, :acceptable_terrain, :rides, :time

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = Hash.new { |hash, key| hash[key] = [] } 
        @acceptable_terrain = []
        @time = time
    end

    def learn_terrain!(terrain)
        @acceptable_terrain << terrain
    end

    def time
        @time
    end

    def log_ride(ride, time)
          @rides[ride] << time
        end

    def personal_record(ride)
        @rides[ride].min

    
end
end