require 'yaml'
require_relative 'star_system'

# TODO: add name and coords validation do systems

module Universe
  class Map

    attr_reader :star_systems

    def initialize
      load_from_file('./universe/map.yml')
    end

    def accessible_systems(from, radius)
      @star_systems.select do |system|
        next if system == from
        from.distance_to(system) <= radius
      end
    end

    def find(name)
      @star_systems.detect {|s| s.name == name}
    end

    private

    def load_from_file(file)
      contents = YAML.load_file(file)
      @star_systems = contents.fetch('star_systems').map do |hash|
        StarSystem.new(*hash.values_at('name', 'x', 'y'))
      end
    end

  end
end