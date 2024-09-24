require './lib/biker'

class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    # array of Biker objects
    @bikers << biker
    # @bikers = @bikers.sort.uniq
  end

  def most_rides
    # Biker object
    @bikers.each do |biker|
    end
  end

  def best_time(ride)
    best_for_ride = 0
    best_biker = nil

    @bikers.each do |biker|
      bikers_best = biker.personal_record(ride)
      # best_for_ride = bikers_best if bikers_best > best_for_ride
      if bikers_best > best_for_ride
        best_for_ride = bikers_best
        best_biker = biker
      end
    end
    # Biker object
    best_biker
  end

  def bikers_eligible(ride)
    eligible = []
    @bikers.each do |biker|
      eligible << biker if biker.acceptable_terrain.include?(ride.terrain)
    end
    # array of Biker objects
    eligible
  end
end

