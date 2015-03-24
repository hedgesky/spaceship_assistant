# encoding: utf-8
# ABOUT:
# This class hides architecture of underlying ship/universe system,
# building all necessary objects and orchestrating them for user.

require_relative 'universe/presenters/map_as_table.rb'

class SpaceshipAssistant

  attr_reader :name, :ship

  # required fields:
  #   :ship
  #   :map
  #   :current_star_system
  # optional fields:
  #   :name - 'Znayka-1' by default
  def initialize(attrs)
    @ship = attrs.fetch(:ship)
    @map = attrs.fetch(:map)
    @current_star_system = attrs.fetch(:current_star_system)

    @name = attrs[:name] || 'Znayka-1'
    #we will go to Bharat
    say 'Я инициализирован'
  end

  def status
    @ship.status.each do |component_name, status|
      if status == :ok
        say "#{component_name} в норме"
      else
        warning "#{component_name} не в порядке: #{status}"
      end
    end
  end

  # -------------
  # NAVIGATION
  # -------------

  def show_map
    marks = {@current_star_system => '*'}
    puts
    Universe::Presenters::MapAsTable.show(@map, marks)
    puts
  end

  def select_star_system_and_jump
    if accessible_systems.empty?
      puts 'Нет целей для прыжка'
      return
    end
    selected_star_system = choose_from_array(accessible_systems, message: 'Куда летим?')
    jump(selected_star_system)
    @current_star_system = selected_star_system
  end

  # there is nothing in space systems yet, so there is no need to flying around in them
  #
  # def fly(distance_in_km, speed=nil)
  #   begin
  #     @ship.fly(distance_in_km, speed)
  #     say "Ship flew #{distance_in_km} km"
  #   rescue Spaceship::TooHighSpeed
  #     error 'Too high speed'
  #   end
  # end

  def jump(to)
    distance = @current_star_system.distance_to(to)
    begin
      @ship.jump(distance)
      say "Корабль прыгнул в систему #{to.name}"
    rescue Spaceship::TooLongJumpDistance
      error 'Корабль не может прыгнуть так далеко'
    rescue Spaceship::NotEnoughFuel
      error 'Недостаточно топлива'
    end
  end

  def fuel!
    fuel_amount = get_integer(message: 'На сколько заправлять?')
    fueled = @ship.fuel!(fuel_amount)
    say "Заправлен на #{fueled}"
  end

  def choose_next_action
    next_action = choose_from_hash({
      select_star_system_and_jump: 'Совершить прыжок',
      fuel!: 'Заправиться',
      show_map: 'Показать карту',
      show_accessible_systems: 'Показать доступные для прыжка системы'
    })
    send(next_action)
  end

  def show_accessible_systems
    puts accessible_systems
  end

  private

  def accessible_systems
    limiting_factor = [@ship.fuel, @ship.max_jump_length].min
    @map.accessible_systems(@current_star_system, limiting_factor)
  end

  def say(message)
    puts "#{name}: #{message}"
  end

  def warning(message)
    say "Warning! #{message}"
  end

  def error(message)
    say "Error! #{message}"
  end

end