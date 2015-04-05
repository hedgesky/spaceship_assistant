class Ai
  class Attitude

    AVAILABLE = [:hostile, :neutral, :friendly]

    def initialize(attitude)
      unless AVAILABLE.include?(attitude)
        raise 'wrong attitude'
      end
      @attitude = attitude
    end

    def hostile?
      @attitude == :hostile
    end

    def neutral?
      @attitude == :neutral
    end

    def friendly?
      @attitude == :friendly
    end

    def to_s
      case @attitude
      when :hostile
        'Враг'
      when :neutral
        'Нейтральный'
      when :friendly
        'Дружественный'
      end
    end

  end
end