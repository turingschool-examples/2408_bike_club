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
    @rides[ride] ||= []
    @rides[ride] << ride_time
  end

  def personal_record(ride)
      @rides[ride].min 
  end
end