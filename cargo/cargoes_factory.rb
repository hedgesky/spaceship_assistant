require_relative 'cargo'

class CargoesFactory
  def initialize
    load_from_file('./cargo/cargoes.yml')
  end

  def get(name)
    @cargoes.detect { |cargo| cargo.name == name }
  end

  def random(count = 1)
    @cargoes.sample(count)
  end

  def random_collection
    count = rand(@cargoes.size + 1)
    random(count)
  end

  private

  def load_from_file(file)
    @cargoes = YAML.load_file(file).map do |attrs|
      Cargo.new(attrs)
    end
  end
end