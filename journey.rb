# encoding: utf-8
require_relative 'initializers/patch_colorize'
require_relative 'lib/input_utils'
require_relative 'universe/map'
require_relative 'spaceship/spaceship_factory'
require_relative 'spaceship_assistant'

include InputUtils

map = Universe::Map.new
sun = map.find('Солнце')
factory = SpaceshipFactory.new(map: map, default_star_system: sun)
map.populate_ships_with_factory!(factory)

player_ship = factory.build_ship(:user, name: 'Энтерпрайз')
assistant = SpaceshipAssistant.new(ship: player_ship)
assistant.start_journey