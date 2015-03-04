# a lot of awesome functionality will soon appear here
class SpaceshipAssistant

  attr_reader :name

  def initialize(name='Znayka-1')
    @name = name
    say 'Assistant initialized'
  end

  def status
    say 'All systems are OK'
  end

  private

  def say(message)
    puts "#{name}: #{message}"
  end

  def warning(message)
    say "Warning! #{message}"
  end
end