class Ride
  attr_reader :name, :distance, :terrain, :loop

  def initialize(details)
    @name = details[:name]
    @distance = details[:distance]
    @terrain = details[:terrain]
    @loop = details[:loop]
  end
  
  def loop?
    @loop
  end
end