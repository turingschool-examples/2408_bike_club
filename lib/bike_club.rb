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

end