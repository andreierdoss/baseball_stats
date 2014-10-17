namespace :stats do
  task :most_improved_batting_average do
    viewer = BattingAverageStatViewer.new(BattingAverageStat.new)
    puts viewer.display_most_improved(2009, 2010) 
    puts "\n\n"
  end

  task :slugging_percentage do
    viewer = SluggingPercentageStatViewer.new(SluggingPercentageStat.new)
    puts viewer.display_slugging_percentage('OAK', 2007)
    puts "\n\n"
  end

  task all: [:most_improved_batting_average, :slugging_percentage]
end
