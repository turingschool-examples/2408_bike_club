class Ride

    attr_reader :name, :distance, :terrain, :loop
    

    def initialize(ride_details)
        @name = ride_details[:name]
        @distance = ride_details[:distance]
        @terrain = ride_details[:terrain]
        @loop = ride_details[:loop]
    end

    def loop?
        @loop
    end
end