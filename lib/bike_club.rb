class BikeClub
    attr_reader :name,
                :bikers

    def initialize(name)
        @name = name
        @bikers = []
    end

    def add_biker(biker)
        @bikers << biker
    end

    def most_rides
        @bikers.max_by { |biker| biker.rides.count }
    end

    def best_time(ride)
        best_biker = ""
        best_time =  999.99

        @bikers.each do |biker|
            if biker.rides.key?(ride)
                biker_best = biker.rides[ride].min
                if biker_best < best_time
                    best_time = biker_best
                    best_biker = biker
                end
            end
            return best_biker.name
        end
    end

    def bikers_eligible(ride)
        @bikers.find_all do |biker|
            binding.pry
            biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
        end
    end
end