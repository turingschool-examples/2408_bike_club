class Biker
  attr_reader :name,
              :max_distance,
              :rides,
              :acceptable_terrain
  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = {}
    @acceptable_terrain = []
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain unless @acceptable_terrain.include?(terrain)
  end

  def log_ride(ride, ride_time)
    if @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
      @rides[ride] ||= []
      @rides[ride] << ride_time
    end
  end

  def personal_record(ride)
    if @rides.has_key?(ride) && !@rides[ride].empty?
      @rides[ride].min
    else
      false
    end
  end
end