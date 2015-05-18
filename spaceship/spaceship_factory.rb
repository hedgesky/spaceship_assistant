# encoding: utf-8
require_relative 'spaceship'
require_relative '../ai/ai'
require_relative '../cargo/cargoes_factory'

class SpaceshipFactory

  def initialize(attrs)
    @map = attrs.fetch(:map)
  end

  def build_ship(ship_class, attrs={})
    ship = build_ship_instance(ship_class, attrs)
    ship.ai = attrs[:ai] || Ai.new
    ship.load_cargoes!(attrs[:cargoes] || cargoes_factory.random_collection)
    ship.fuel!(ship.max_fuel_amount)
    ship
  end

  def cargoes_factory
    @cargoes_factory ||= CargoesFactory.new
  end

  private


    def build_ship_instance(ship_class, attrs)
      raise 'Неверный код корабля' unless available_ship_classes.include?(ship_class)
      attrs = attrs.dup
      attrs[:name] ||= random_name
      attrs[:map] = @map

      attrs.merge!(special_attrs_for_ship_class(ship_class))
      Spaceship.new(attrs)
    end

    def special_attrs_for_ship_class(ship_class)
      send(ship_class)
    end

    AVAILABLE_NAMES = %w(John Nick Camelot Vampire Albus Potter Watson Sherlock EachEach CabbageKnight Hedgesky Rubier)

    def random_name
      if @not_used_names.nil? || @not_used_names.empty?
        @not_used_names = AVAILABLE_NAMES.shuffle
      end
      @not_used_names.pop
    end


    def available_ship_classes
      [:user, :enemy, :trade]
    end

    # different spaceship attrs below
    def user
      {
        max_speed: 10000,
        max_jump_length: 10,
        max_fuel_amount: 10
      }
    end

    def enemy
      {
        max_speed: 10000,
        max_jump_length: 10,
        max_fuel_amount: 10
      }
    end

    def trade
      {
        max_speed: 10000,
        max_jump_length: 10,
        max_fuel_amount: 10
      }
    end

end