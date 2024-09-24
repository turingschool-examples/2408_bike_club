class Biker

    attr_reader :name, :max_distance, :acceptable_terrain, :rides

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = Hash.new { |hash, key| hash[key] = [] } 
        @acceptable_terrain = []
    end

    def learn_terrain!(terrain)
        @acceptable_terrain << terrain
    end

    def log_ride(ride, time)
        if can_ride?(ride)
          @rides[ride] << time
        else
          return false
        end
      end

      def can_ride?(ride)
        @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
      end

      def personal_record(ride)
        return false unless can_ride?(ride)
        @rides[ride].min
    end
end