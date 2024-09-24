class Ride
  attr_reader :name, :distance, :loop, :terrain

  def initialize(ride_details)
    @name = ride_details[:name]
    @distance = ride_details[:distance]
    @loop = ride_details[:loop]
    @terrain = ride_details[:terrain]
  end

  def total_distance
    return @distance if @loop

    @distance * 2
  end
end

