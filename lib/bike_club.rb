class BikeClub


    def initialize(name)
        @name = name
        @bikers = []
    end
        
    def add_biker(biker)
        @bikers << biker
        @bikers
    end
     
    def most_rides

    end

    def best_time(ride)

    end

    def bikers_eligible(ride)
        eligiblebikers = []
        @bikers.each do |biker| 
            if biker.acceptable_terrain.include?(ride.terrain)
                eligiblebikers << biker
            end
        end
        eligiblebikers
    end

end