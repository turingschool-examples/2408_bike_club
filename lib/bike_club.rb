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

        @bikers.max_by(&:ride_count)
    end

    def best_time(ride)
        return nil if @bikers.empty?
        @bikers.max_by { |biker| biker.total_time_for_ride(ride) }
    end    

    def best_time(ride)
        return nil if @bikers.empty?

        best_biker = nil
        best_time = nil

        @bikers.each do |biker|
            ride_times = biker.rides[ride]
            
            if ride_times && !ride_times.empty?
                time = ride_times.min

                if best_time.nil? || time < best_time
                    best_time = time
                    best_biker = biker
                end
            end
        end

        best_biker
    end   
end