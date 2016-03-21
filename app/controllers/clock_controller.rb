class ClockController < ApplicationController

  def welcome
    puts ":: Welcome to Transit Clock ::"
    puts "Press Return to quit\n\n"
  end

  def start
    welcome

    Thread.new do
      while true do
        STDOUT.print "#{DateTime.now.strftime("%a %d %b ~ %I:%M:%S.%L %p")} | #{next_trains}\r"
        sleep 0.04
      end
    end

    STDIN.gets
  end

  def next_trains
    if two_min_passed? || @trip.nil?
      @trip = Trip.new(current_address, destination_address)
      @trip.retrieve!
    end
    @trip
  end

  def current_address
    "163 attorney st, New York NY 10002"
  end

  def destination_address
    "433 W 14th st, new york ny 10014"
  end

  def two_min_passed?
    current_min = Time.now.min
    if (current_min % 2) == 0 && current_min != @last_min_check
      @last_min_check = current_min
      true
    else
      false
    end
  end

end
