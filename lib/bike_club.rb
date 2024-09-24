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
        ride_count_hash.key(ride_count_hash.values.max)
    end

    def best_time(ride)
        biker_time_hash = {}
        @bikers.map do |biker|
            if biker.personal_record(ride) != false
                biker_time_hash[biker] ||= 0
                biker_time_hash[biker] = biker.personal_record(ride)
            end
        end
        biker_time_hash.key(biker_time_hash.values.min)
    end
end