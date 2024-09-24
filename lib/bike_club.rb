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
        ride_count_hash = {}
        @bikers.map do |biker|
            biker.rides.map do |ride| 
                ride_count_hash[biker] ||= 0
                    ride_count_hash[biker] += ride[1].count
            end
        end
        most_rides_biker = ride_count_hash.key(ride_count_hash.values.max)
        most_rides_biker
    end
end