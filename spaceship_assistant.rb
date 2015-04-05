# encoding: utf-8
# ABOUT:
# This class hides architecture of underlying ship/universe system,
# building all necessary objects and orchestrating them for user.

require_relative 'universe/presenters/map_as_table.rb'

class SpaceshipAssistant

  attr_reader :name, :ship

  # required fields:
  #   :ship
  # optional fields:
  #   :name - @ship.name by default
  def initialize(attrs)
    @ship = attrs.fetch(:ship)
    @ship.fuel!(10)

    @name = attrs[:name] || @ship.name
    #we will go to Bharat

    say 'Я инициализирован'
  end

  def start_journey
    trap("INT") { puts "\nДо новых встреч!"; exit}
    loop do
      begin
        say 'Ожидаю приказов'
        break if choose_next_action == :quit
        puts "\n"*3
      rescue ActionCancelled
        puts 'Действие отменено'
        puts
      end
    end
    puts "\nДо новых встреч!"
  end

  def status
    engine_status = [
      "Топливо: #{ship.fuel_amount} / #{ship.max_fuel_amount}",
      "Макс. длина прыжка: #{ship.max_jump_length}"
    ].join("\n")

    rows = [['Двигатель', engine_status]]

    puts Terminal::Table.new(rows: rows, title: 'Состояние корабля')
  end

  # -------------
  # NAVIGATION
  # -------------

  def show_map
    marks = {}
    ship.accessible_systems.each do |system|
      marks[system] = '+'
    end

    marks[@ship.current_star_system] = '*'

    puts
    Universe::Presenters::MapAsTable.show(@ship.map, marks)
    puts
    puts '* – Текущая система'
    puts '+ – Можно прыгнуть'
  end

  def select_star_system_and_jump
    if ship.accessible_systems.empty?
      puts 'Нет целей для прыжка'
      return
    end
    selected_star_system = choose_index_from_table(
      ship.accessible_systems,
      message: 'Куда летим?: ',
      title: 'Доступные системы'
    )
    jump(selected_star_system)
  end

  def select_fuel_amount_and_fuel
    fuel_amount = get_integer(message: 'На сколько заправлять?: ')
    fueled = @ship.fuel!(fuel_amount)
    say "Заправлен на #{fueled}"
  end

  def show_current_system_info
    title = ship.current_star_system.name
    rows = []

    ships = ship.current_star_system.ships.map do |ship|
      "#{ship.name} (#{ship.ai.attitude})"
    end.join("\n")

    rows << ["Корабли в системе:\n", ships]

    puts Terminal::Table.new(rows: rows, title: title)
  end

  private

  def choose_next_action
    next_action = choose_from_hash({
      status: 'Состояние корабля',
      select_star_system_and_jump: 'Совершить прыжок',
      select_fuel_amount_and_fuel: 'Заправиться',
      show_map: 'Показать карту',
      show_current_system_info: 'Информация о текущей системе',
      quit: 'Закончить'
    })

    send(next_action) if next_action != :quit
    next_action
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