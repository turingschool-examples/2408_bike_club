class BikeClub
  attr_reader :name, :bikers
    def initialize(name)
      @name = name
      @bikers = []
    end

    def add_bikers(biker)
      @bikers << biker
      return @bikers
    end

    def most_rides
      return nil if @bikers.empty?

      @bikers.max_by do |biker|
          biker.rides.count
      end
    end
end