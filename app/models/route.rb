class Route

  attr_reader :departure_time,
              :arrival_time

  def initialize(gmaps_route)
    @gmaps_route = gmaps_route
    @first_leg = @gmaps_route["legs"][0]
    @departure_time = RouteDateTime.strptime(@first_leg["departure_time"]["value"].to_s, "%s")
    @arrival_time = RouteDateTime.strptime(@first_leg["arrival_time"]["value"].to_s, "%s")

    @steps = []

    @first_leg["steps"].each do |step|
      @steps << Step.new(step)
    end
  end

  def first_step
    @first_step ||= @steps.reject { |step| step.travel_mode == "WALKING" }[0]
  end

end
