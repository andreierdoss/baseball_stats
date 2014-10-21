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

  task :triple_crown do
    viewer = BattingAverageStatViewer.new(BattingAverageStat.new)
    puts "Triple Crown Winner(s)"
    puts viewer.display_triple_crown_winner('AL', 2011)
    puts viewer.display_triple_crown_winner('NL', 2011)
    puts viewer.display_triple_crown_winner('AL', 2012)
    puts viewer.display_triple_crown_winner('NL', 2012)
  end

  task all: [:most_improved_batting_average, :slugging_percentage, :triple_crown]
end
