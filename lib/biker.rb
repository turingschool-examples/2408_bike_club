class Biker

    attr_reader :name, :max_distance, :ride_details

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
    end
end