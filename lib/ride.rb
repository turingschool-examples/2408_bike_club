class Ride
  attr_reader :name,
              :distance,
              :loop,
              :terrain

  def initialize(data)
    @name = data[:name]
    @distance = data[:distance]
    @loop = data[:loop]
    @terrain = data[:terrain]
  end

  def loop?
  @loop
  end

  def total_distance
    if loop?
      @distance
    else
      @distance * 2
    end
  end

end