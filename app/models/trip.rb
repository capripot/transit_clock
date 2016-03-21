class Trip

  attr_accessor :from,
                :to


  def initialize(from, to)
    @from = from
    @to = to
    @routes = []
  end

  def retrieve!
    @api_answer = Google::Maps::Directions.new({
      origin: @from,
      destination: @to
    }).get

    if @api_answer["routes"]
      @api_answer["routes"].each do |route|
        @routes << Route.new(route)
      end
    end
  end

  def routes
    @routes
  end

  def to_s
    @routes.map do |route|
      "#{route.arrival_time} -> #{route.departure_time} #{route.first_step}"
    end.join(" / ")
  end
end
