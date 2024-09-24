class BikeClub

        attr_reader :name, :bikers
        def initialize(name)
            @name = name
            @bikers = []
          end
        
          def add_biker(biker)
            @bikers << biker
          end
        
          def best_time(ride)
            @bikers.min_by { |biker| biker.personal_record(ride) }
          end
        
          def bikers_eligible(ride)
            @bikers.select do |biker|
              biker.acceptable_terrain.include?(ride.terrain) && biker.max_distance >= ride.distance
            end
          end
        end
      
    
