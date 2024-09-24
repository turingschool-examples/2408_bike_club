class BikeClub
    attr_reader :name, :bikers
    def initialize(name)
        @name = name
        @bikers = []
    end

    

    def most_rides
        @bikers.max_by {|biker| biker.rides.values.sum(&:size)}
    end
end