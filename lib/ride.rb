class Ride
  attr_reader :name,
              :distance,
              :terrain

  def initialize(att)
    @name = att[:name]
    @distance = att[:distance]
    @loop = att[:loop]
    @terrain = att[:terrain]
  end

  def loop?
    @loop
  end

  def total_distance
    loop? ? distance : distance * 2
  end
end