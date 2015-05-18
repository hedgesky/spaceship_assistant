class Cargo

  attr_reader :name, :average_cost, :weight

  def initialize(attrs)
    @name = attrs.fetch(:name)
    @average_cost = attrs.fetch(:average_cost)
    @weight = attrs.fetch(:weight)
  end

end