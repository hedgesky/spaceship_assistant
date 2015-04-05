require_relative 'components/engine.rb'
require_relative 'components/navigator.rb'
require_relative 'exceptions.rb'
require 'forwardable'

class Spaceship
  extend Forwardable

  attr_reader :name

  delegate({
    [:fuel_amount, :max_jump_length, :jump_light_years!, :fuel!] => :engine,
    [:accessible_systems, :current_star_system, :map, :jump!] => :navigator
  })

  # attrs should include:
  #   :name
  #   :max_speed
  #   :max_jump_length
  #   :max_fuel_amount
  #   :map
  #   :current_star_system
  def initialize(attrs)
    @name = attrs.fetch(:name)
    @engine = Components::Engine.new(attrs.fetch(:max_speed), attrs.fetch(:max_jump_length), attrs.fetch(:max_fuel_amount))
    @navigator = Components::Navigator.new(self, attrs.fetch(:map), attrs.fetch(:current_star_system))
  end

  def status
    ship_status = {}
    components.map do |component|
      ship_status[component.name] = component.status
    end
    ship_status
  end

  def components
    [@engine]
  end

  private

  attr_reader :engine, :navigator
end