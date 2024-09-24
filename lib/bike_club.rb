class BikeClub
  attr_reader :name, :bikers, :group_rides

  def initialize(name)
    @name = name
    @bikers = []
    @group_rides = []
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

  def bikers_eligible(ride)
    bikers.select do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
    end
  end

  def record_group_ride(ride)
    eligible_bikers = bikers_eligible(ride)
      
    ride_data = {
      start_time: Time.now,
      ride: ride,
      members: eligible_bikers
    }

    @group_rides << ride_data
    ride_data
  end
end