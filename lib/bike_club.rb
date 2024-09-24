class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
    @bikers
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.values.sum(&:length) }
  end

  def best_time(ride)
    @bikers.min_by { |biker| biker.personal_record(ride) }
  end
end