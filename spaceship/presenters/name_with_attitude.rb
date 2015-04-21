class Spaceship
  module NameWithAttitude
    def name_with_attitude
      "#{name} (#{ai.attitude.to_s.colorize(attitude_color)})"
    end

    def colorized_name
      name.colorize(attitude_color)
    end

    private

    def attitude_color
      color = case ai.attitude.to_sym
      when :hostile
        :red
      when :neutral
        :blue
      when :friendly
        :green
      end
    end
  end
end