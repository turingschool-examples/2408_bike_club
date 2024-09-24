class Ride
    attr_reader :name, :distance, :terrain
    
    def initialize(info)
        @name = info[:name]
        @distance = info[:distance]
        @loop = info[:loop]  # Keep the original @loop for internal use
        @terrain = info[:terrain]
    end
    
    def loop?  # Provide the boolean check
        @loop
    end
    
    def total_distance
        loop? ? distance : distance * 2
    end
end