require_relative '../spaceship/spaceship_factory'

module Universe
  class StarSystem

    attr_reader :name, :x, :y
    attr_accessor :ships

    def initialize(name, x, y)
      raise 'x should be >= 0' if x < 0
      raise 'y should be >= 0' if y < 0
      @name, @x, @y = name, x, y
    end

    def distance_to(another)
      Math.sqrt((x-another.x)**2 + (y-another.y)**2)
    end

    def to_s
      name
    end

  end
end