class Biker
  attr_reader :name,
              :max_distance,
              :rides
  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = {}
  end
end