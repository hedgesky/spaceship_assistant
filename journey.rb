require_relative 'lib/input_utils'
require_relative 'universe/map'
require_relative 'spaceship/spaceship'
require_relative 'spaceship_assistant'

include InputUtils

ship = Spaceship.new(max_speed: 10000, max_jump_length: 10, max_fuel_amount: 10)
map = Universe::Map.new
assistant = SpaceshipAssistant.new(
  ship: ship,
  map: map,
  current_star_system: map.find('Солнце')
)

assistant.status
assistant.show_map

fuel_amount = get_integer(message: 'На сколько заправлять?')

assistant.fuel!(fuel_amount)
assistant.select_star_system_and_jump
assistant.show_map
