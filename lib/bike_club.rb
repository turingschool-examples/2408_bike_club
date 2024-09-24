class BikeClub
    attr_reader :name, :bikers
    def initialize(name)
        @name = name
        @bikers = []
    end

    def add_biker(biker)
        @bikers << biker
    end

    def most_rides
        @bikers.max_by {|biker| biker.rides.values.sum(&:size)}
    end

    def bikers_eligible(ride)
        @bikers.select { |biker| biker.can_ride?(ride)}
    end

    
end