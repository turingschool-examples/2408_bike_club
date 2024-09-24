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
        @acceptable_terrain << terrain
    end

    def log_ride(ride,time)
        unless @acceptable_terrain.include?(ride.terrain)
            raise "You need to learn this terrain to ride #{ride.name}."
        end
        
        @rides[ride] ||= []
        @rides[ride] << time
    end

    def personal_record(ride)
        return false unless @rides[ride]
        @rides[ride].min
    end

    def ride_count
    @rides.values.flatten.count
    end

    def best_time(ride)
        return nil if @bikers.empty?
        best_biker = @bikers.max_by { |biker| biker.personal_record(ride) }
        best_biker if best_biker && best_biker.personal_record(ride) 
    end
    
end
