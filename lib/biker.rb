class Biker
  attr_reader :name, :age, :acceptable_terrain, :rides, :max_distance

  def initialize(name, age)
    @name = name
    @age = age
    @acceptable_terrain = []
    @rides = {}
    @max_distance = 100
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain
    @acceptable_terrain = @acceptable_terrain.sort.uniq
    terrain
  end

  def log_ride(ride, time)
    unless @acceptable_terrain.include?(ride.terrain)
      puts "#{@name} doesn't know this terrain yet"
      return false
    end

    unless @max_distance >= ride.distance
      puts "#{@name} can't ride that far!"
      return false
    end
    @rides[ride] = [] unless @rides.key?(ride)
    @rides[ride] << time

    true
  end

  def personal_record(ride)
    return false unless @rides.key?(ride)

    ride_min = @rides[ride].min
    puts "#{@name}'s best time for #{ride.name}
      is #{ride_min} minutes."
    ride_min
  end
end

