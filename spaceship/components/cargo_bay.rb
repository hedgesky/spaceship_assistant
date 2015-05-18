class Spaceship
  class CargoBay

    attr_reader :cargoes

    def initialize
      @cargoes = []
    end

    def load_cargoes!(cargoes)
      @cargoes += cargoes
    end

  end
end