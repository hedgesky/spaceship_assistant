require_relative 'components/engine.rb'
require_relative 'exceptions.rb'

class Spaceship

  # attrs should include:
  #   :max_speed
  #   :max_jump_length
  #   :max_fuel_amount
  def initialize(attrs)
    @engine = Components::Engine.new(attrs.fetch(:max_speed), attrs.fetch(:max_jump_length), attrs.fetch(:max_fuel_amount))
  end

  def status
    ship_status = {}
    components.map do |component|
      ship_status[component.name] = component.status
    end
    ship_status
  end

  # ENGINE
  def jump(distance_in_light_years)
    @engine.jump(distance_in_light_years)
  end

  def fly(distance_in_km, speed=nil)
    @engine.fly(distance_in_km, speed)
  end

  def fuel!(fuel_amount)
    @engine.fuel!(fuel_amount)
  end

  def fuel
    @engine.fuel
  end

  def max_jump_length
    @engine.max_jump_length
  end

  def components
    [@engine]
  end
end