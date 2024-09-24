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
        return nil if @bikers.empty?
        @bikers.max_by { |biker| biker.rides.length }
    end

    def best_time(ride)
        best_biker = nil
        best_time = Float::INFINITY

        @bikers.each do |biker|
            if biker.rides.key?(ride)
                times = biker.rides[ride]
                current_best_time = times.min

                if current_best_time < best_time
                    best_time = current_best_time
                    best_biker = biker 
                end
            end
        end
        best_biker
    end

    def bikers_eligible(ride)
        bikers_eligible = []

        @bikers.each do |biker|
            if ride && biker.acceptable_terrain.include?(ride.terrain)
                bikers_eligible << biker
            end
        end
        bikers_eligible
    end
end