class Spaceship
  class TooHighSpeed < StandardError; end
  class TooLongJumpDistance < StandardError; end
  class NotEnoughFuel < StandardError; end
  class NotEnoughEmptySpaceInTheTank < StandardError; end
end