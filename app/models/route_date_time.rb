class RouteDateTime < DateTime

  def to_s
    self.in_time_zone("Eastern Time (US & Canada)").strftime("%l:%M%P")
  end

end
