class Spaceship
  module Components
    class Engine

      attr_reader :fuel_amount, :max_fuel_amount, :max_jump_length

      def initialize(max_speed, max_jump_length, max_fuel_amount)
        @max_speed, @max_jump_length = max_speed.to_f, max_jump_length.to_f
        @max_fuel_amount = max_fuel_amount
        @fuel_amount = 0
      end

      def status
        :ok
      end

      def fuel!(fuel_amount)
        fueled = [fuel_amount, @max_fuel_amount - @fuel_amount].min
        @fuel_amount += fueled
        fueled
      end

      def jump_light_years!(distance_in_light_years)
        fuel_amount = distance_in_light_years
        raise Spaceship::NotEnoughFuel if fuel_amount > @fuel_amount
        @fuel_amount -= fuel_amount

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