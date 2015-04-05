require_relative 'spaceship'
require 'singleton'

class SpaceshipFactory

  def initialize(attrs)
    @map = attrs.fetch(:map)
    @default_star_system = attrs.fetch(:default_star_system)
  end

  def build_ship(code, attrs={})
    raise 'Неверный код корабля' unless available_ships.include?(code)

    attrs[:name] ||= random_name
    attrs[:map] = @map
    attrs[:current_star_system] ||= @default_star_system

    attrs.merge!(special_attrs_for_code(code))

    Spaceship.new(attrs)
  end


  private

    def special_attrs_for_code(code)
      send(code)
    end

    AVAILABLE_NAMES = %w(John Nick Camelot Vampire Albus Potter Watson Sherlock EachEach CabbageKnight Hedgesky Rubier)

    def random_name
      if @not_used_names.nil? || @not_used_names.empty?
        @not_used_names = AVAILABLE_NAMES.shuffle
      end
      @not_used_names.pop
    end


    def available_ships
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