require 'pry'
class BikeClub
  attr_reader :name,
              :bikers
@@all_clubs = []

  def initialize(name)
    @name = name
    @bikers = []
    @@all_clubs << self
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by do |biker|
      biker.rides.sum do |ride, times|
        times.count
      end
    end
  end

  def best_time(ride)
    best_biker = nil
    best_time = Float::INFINITY
    @bikers.each do |biker|
      time = biker.rides[ride].compact
      biker_time = time.min
      if biker_time < best_time 
        best_time = biker_time
        best_biker = biker
      end
    end
    best_biker
  end

  def eligible(ride)
    elidgible_bikers = []
    @bikers.each do |biker|
      if biker.acceptable_terrain.include?(ride.terrain) && biker.max_distance >= ride.total_distance
        elidgible_bikers << biker 
      end
    end
    elidgible_bikers
  end

  def self.best_rider(ride)
    best_biker = nil
    best_time = Float::INFINITY

    @@all_clubs.each do |club|
      club.bikers.each do |biker|
        if biker.rides[ride]
          time = biker.rides[ride].min
          if time < best_time
            best_time = time
            best_biker = biker
          end
        end
      end
    end

    best_biker
  end
end