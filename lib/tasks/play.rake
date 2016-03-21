desc "Play the app"
task play: :environment do
  ClockController.new.start
end
