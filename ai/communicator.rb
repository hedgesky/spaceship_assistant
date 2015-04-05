class Ai
  class Communicator

    def greeting(attitude, ship_name)
      {
        hostile: 'Проваливай, пока я не успел зарядить свои пушки!',
        neutral: "Приветствую, #{ship_name}!",
        friendly: "Привет, #{ship_name}! Как дела?"
      }.fetch(attitude)
    end


  end
end