require_relative 'spaceship'
require_relative '../ai/ai'

class SpaceshipFactory

  def initialize(attrs)
    @map = attrs.fetch(:map)
    @default_star_system = attrs.fetch(:default_star_system)
  end

  def build_ship(ship_class, attrs={})
    raise 'Неверный код корабля' unless available_ship_classes.include?(ship_class)

    attrs[:name] ||= random_name
    attrs[:map] = @map
    attrs[:current_star_system] ||= @default_star_system

    attrs.merge!(special_attrs_for_ship_class(ship_class))

    ship = Spaceship.new(attrs)
    ship.ai = Ai.new
    ship
  end


  private

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