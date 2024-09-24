class Ride

  attr_reader :name, :distance, :terrain
  
  def initialize(attributes)
    @name = attributes[:name]
    @distance = attributes[:distance]
    @loop = attributes[:loop]
    @terrain = attributes[:terrain]
  end

  def total_distance
    if @loop 
      @distance
    else
      @distance * 2
    end
  end

  def loop?
    @loop
  end
end