class BikeClub
    attr_reader :name, :bikers

    def initialize(name)
        @name = name
        @bikers = []
    end
        
    def add_biker(biker)
        @bikers << biker
        @bikers
    end
     
    def most_rides
        @bikers.max_by do |biker| #finds biker with most logged rides

            biker.rides.keys.size
            #returns the amount of keys the biggewst biker has(different rides)
        end
    end


    end

    def best_time(ride)
        personalrecords = {}
        @bikers.each do |biker|

            #biker personal record for given ride put it in as their name as the key, 
            #the record as the value and then find the highest value and return 
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