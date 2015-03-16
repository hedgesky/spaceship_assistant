class Spaceship
  module Components
    class Engine
      def initialize(max_speed, max_jump_length, max_fuel)
        @max_speed, @max_jump_length = max_speed.to_f, max_jump_length.to_f
        @max_fuel = max_fuel
        @fuel = 0
      end

      def status
        :ok
      end

      def fuel(fuel_amount)
        @fuel += fuel_amount
      end

      def jump(distance_in_light_years)
        fuel_amount = distance_in_light_years
        raise Spaceship::NotEnoughFuel if fuel_amount > @fuel
        @fuel -= fuel_amount

        raise Spaceship::TooLongJumpDistance if distance_in_light_years > @max_jump_length
        distance_in_light_years
      end

      def fly(distance_in_km, speed = nil)
        speed ||= @max_speed
        raise Spaceship::TooHighSpeed if speed > @max_speed
        distance_in_km
      end

      def name
        'Engine'
      end
    end
  end
end