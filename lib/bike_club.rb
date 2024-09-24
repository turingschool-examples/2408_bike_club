class BikeClub
  attr_reader :name,
              :bikers,
              :group_rides

  def initialize(name)
    @name = name
    @bikers = []
    @group_rides = []
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

  def bikers_eligible(ride)
    @bikers.select { |biker| biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance }
  end

  def record_group_ride(ride)
    eligible_riders = bikers_eligible(ride)
    group_ride = {
      start_time: Time.now,
      ride: ride,
      members: eligible_riders
    }
    @group_rides << group_ride
    group_ride
  end

  def finish_ride(biker)
    current_ride = @group_rides.last
    return unless rider_part_of_ride?(biker, current_ride)

    ride_time = calculate_ride_time(current_ride[:start_time])
    biker.log_ride(current_ride[:ride], ride_time)
  end

  def rider_part_of_ride?(biker, ride)
    ride && ride[:members].include?(biker)
  end

  def calculate_ride_time(start_time)
    ((Time.now - start_time) / 60).to_i
  end
end