class BikeClub

    attr_accessor   :name,
                    :bikers
    @@all_bike_clubs = []
    def initialize(name)
        @name = name
        @bikers = []
        @@all_bike_clubs << self
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
                biker_time_hash[biker] = biker.personal_record(ride)
            end
        end
        biker_time_hash.key(biker_time_hash.values.min)
    end

    def bikers_eligible(ride)
        eligible =[]
        @bikers.map do |biker|
            if biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
                eligible << biker
            end
        end
        eligible
    end

    # def record_group_ride(ride)
    #     group_hash={}
    #     group_hash[:start_time] = Time.now
    #     group_hash[:ride] = ride
    #     group_hash[:members] = bikers_eligible(ride)
    #     #require "pry" ; binding.pry
    # end

    # def finish_group_ride(ride,biker)
    #     finish_time = Time.now
    #     biker.log_ride(ride)
    # end

    def self.best_time(ride)

        biker_time_hash = {}
        @@all_bike_clubs.map do |bike_club|
            if bike_club.best_time(ride) != nil
                biker_time_hash[bike_club.best_time(ride)] = bike_club.best_time(ride).personal_record(ride)
            end
        end
        biker_time_hash.key(biker_time_hash.values.min)
    end
end