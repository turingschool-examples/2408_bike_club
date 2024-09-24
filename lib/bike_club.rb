class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.length }
  end

  def best_time(ride)
    @bikers
    .select { |biker| biker.rides[ride] }
    .min_by { |biker| biker.rides[ride].min }
  end
end