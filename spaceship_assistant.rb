# a lot of awesome functionality will soon appear here
class SpaceshipAssistant

  attr_reader :name, :ship

  def initialize(ship, name='Znayka-1')
    @name = name
    @ship = ship
    say 'Assistant initialized'
  end

  def status
    @ship.status.each do |component_name, status|
      say "#{component_name} status is #{status}"
    end
  end

  def fly(distance_in_km, speed=nil)
    begin
      @ship.fly(distance_in_km, speed)
      say "Ship flew #{distance_in_km} km"
    rescue Spaceship::TooHighSpeed
      error 'Too high speed'
    end
  end

  def jump(distance_in_light_years)
    begin
      @ship.jump(distance_in_light_years)
      say "Ship jumped by #{distance_in_light_years} light years"
    rescue Spaceship::TooLongJumpDistance
      error 'Too long jump distance'
    rescue Spaceship::NotEnoughFuel
      error 'Not enough fuel'  
    end
  end

  private

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