# encoding: utf-8
# ABOUT:
# This class hides architecture of underlying ship/universe system,
# building all necessary objects and orchestrating them for user.

require_relative 'universe/presenters/map_as_table.rb'
require 'byebug'

class SpaceshipAssistant

  attr_reader :name, :ship

  # required fields:
  #   :ship
  #   :map
  #   :current_star_system
  # optional fields:
  #   :name - @ship.name by default
  def initialize(attrs)
    @ship = attrs.fetch(:ship)
    @ship.fuel!(10)

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
    marks = {}
    ship.accessible_systems.each do |system|
      marks[system] = '+'
    end

    marks[current_star_system] = '*'

    puts
    Universe::Presenters::MapAsTable.show(map, marks)
    puts
  end

  def select_star_system_and_jump
    if ship.accessible_systems.empty?
      puts 'Нет целей для прыжка'
      return
    end
    selected_star_system = choose_index_from_table(ship.accessible_systems, message: 'Куда летим?: ')
    jump(selected_star_system)
  end

  def fuel!
    fuel_amount = get_integer(message: 'На сколько заправлять?: ')
    fueled = @ship.fuel!(fuel_amount)
    say "Заправлен на #{fueled}"
  end

  def choose_next_action
    next_action = choose_from_hash({
      select_star_system_and_jump: 'Совершить прыжок',
      fuel!: 'Заправиться',
      show_map: 'Показать карту',
      show_accessible_systems: 'Показать доступные для прыжка системы',
      quit: 'Закончить'
    })

    send(next_action) if next_action != :quit
    next_action
  end

  def start_journey
    loop do
      begin
        say 'Ожидаю приказов'
        break if choose_next_action == :quit
        puts '   -------   '
      rescue ActionCancelled
        puts 'Действие отменено'
        puts
      end
    end
  end

  private

  def show_accessible_systems
    systems = @ship.accessible_systems.map(&:name)
    table_from_array(systems, 'Доступные системы')
  end

  def map
    @ship.map
  end

  def current_star_system
    @ship.current_star_system
  end

  def jump(to)
    begin
      @ship.jump!(to)
      say "Корабль прыгнул в систему #{to.name}"
    rescue Spaceship::TooLongJumpDistance
      error 'Корабль не может прыгнуть так далеко'
    rescue Spaceship::NotEnoughFuel
      error 'Недостаточно топлива'
    end
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