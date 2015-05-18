require_relative 'components/engine.rb'
require_relative 'components/navigator.rb'
require_relative 'components/cargo_bay.rb'
require_relative 'presenters/name_with_attitude.rb'
require_relative 'exceptions.rb'
require 'forwardable'

class Spaceship
  extend Forwardable
  include NameWithAttitude

  attr_reader :name
  attr_accessor :ai

  delegate({
    [:fuel_amount, :max_fuel_amount, :max_jump_length, :jump_light_years!, :fuel!] => :engine,
    [:accessible_systems, :current_star_system, :map, :jump!] => :navigator,
    [:cargoes, :load_cargoes!] => :cargo_bay
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
    @engine = Engine.new(attrs.fetch(:max_speed), attrs.fetch(:max_jump_length), attrs.fetch(:max_fuel_amount))
    @navigator = Navigator.new(self, attrs.fetch(:map), attrs.fetch(:current_star_system))
    @cargo_bay = CargoBay.new
  end


  private

  attr_reader :engine, :navigator, :cargo_bay

  def components
    [@engine, @navigator, @cargo_bay]
  end

end