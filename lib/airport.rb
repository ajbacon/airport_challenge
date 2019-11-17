require_relative "plane.rb"
class Airport
  attr_reader :capacity
  DEFAULT_CAPACITY = 10

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @planes = []

  end

  def land_plane(plane)
    raise RuntimeError if full?

    @planes << plane
  end

  def take_off(weather)
    raise RuntimeError, "No planes at the airport" if empty?
    raise "Plane cannot take off due stormy weather" if weather.stormy?

    @planes.pop
    "Plane has taken-off"
  end

  private

  def full?
    @planes.count >= @capacity
  end

  def empty?
    @planes.count < 1
  end

end
