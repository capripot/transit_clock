class Step

  attr_reader :instructions,
              :departure_time,
              :travel_mode,
              :subway_line

  def initialize(gmaps_step)
    @instructions = gmaps_step["html_instructions"]
    @transit_details = gmaps_step["transit_details"]
    @travel_mode = gmaps_step["travel_mode"]

    @departure_time = RouteDateTime.strptime(@transit_details["departure_time"]["value"].to_s,'%s') if @transit_details
    @subway_line = @transit_details["line"]["short_name"] if @transit_details
  end

  def subway_logo
    return (subway_line.ord + 0x2475).chr if subway_line[/[A-Z]/]
    return (subway_line.ord + 0x242f).chr if subway_line[/[1-9]/]
    "(#{subway_line})"
  end

  def to_s
    "#{subway_logo} #{@instructions} (#{@departure_time})"
  end

end
