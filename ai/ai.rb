require_relative 'attitude'
require_relative 'communicator'

class Ai
  attr_reader :attitude, :communicator

  def initialize(attitude=nil)
    attitude ||= Attitude::AVAILABLE.sample
    @attitude = Attitude.new(attitude)
  end

  def communicator
    @communicator ||= Communicator.new
  end
end