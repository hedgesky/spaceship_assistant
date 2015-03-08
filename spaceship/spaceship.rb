require_relative 'components/engine.rb'
require_relative 'exceptions.rb'

class Spaceship

  # attrs should include:
  #   :max_speed
  #   :max_jump_length
  def initialize(attrs)
    @engine = Components::Engine.new(attrs.fetch(:max_speed), attrs.fetch(:max_jump_length))
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

  private

  def components
    [@engine]
  end
end