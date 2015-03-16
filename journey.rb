require_relative 'spaceship/spaceship.rb'
require_relative 'spaceship_assistant.rb'

ship = Spaceship.new(max_speed: 10000, max_jump_length: 10, max_fuel_amount: 10)

assistant = SpaceshipAssistant.new(ship)
assistant.status
assistant.fly(300)
assistant.jump(3)
assistant.fly(400, 20000)
assistant.jump(12)