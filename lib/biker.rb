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

  def log_ride(ride, time)
    if can_do_ride?(ride)
      if @rides[ride]
        @rides[ride] << time
      else
        @rides[ride] = [time]
      end
    end
  end

  def can_do_ride?(ride)
    @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
  end

  def personal_record(ride)
    @rides[ride]&.min || false
  end
end