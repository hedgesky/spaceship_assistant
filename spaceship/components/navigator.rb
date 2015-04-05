class Spaceship
  class Navigator

    attr_reader :map, :current_star_system

    def initialize(ship, map, current_star_system)
      @ship = ship
      @map, @current_star_system = map, current_star_system
    end

    def accessible_systems
      limiting_factor = [@ship.fuel_amount, @ship.max_jump_length].min
      @map.accessible_systems(@current_star_system, limiting_factor)
    end

    def jump!(to)
      distance = @current_star_system.distance_to(to)
      @ship.jump_light_years!(distance)
      @current_star_system = to
    end

  end
end