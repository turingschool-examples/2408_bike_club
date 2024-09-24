class Biker

    attr_reader :name, :max_distance, :acceptable_terrain, :rides

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = Hash.new(0)
        @acceptable_terrain = []


    end
end