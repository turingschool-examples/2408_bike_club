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
    @acceptable_terrain << terrain
  end

  def log_ride(ride, ride_time)
    if @acceptable_terrain.include? ride.terrain
      @rides[ride] ||= []
      @rides[ride] << ride_time
    else
      @rides = {}
    end
  end

  def personal_record(ride)
    if @rides.has_key?(ride) && !@rides[ride].empty?
      @rides[ride].min
    else
      nil
    end
  end
end