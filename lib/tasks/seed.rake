namespace :seed do
  task :all do
    Mongoid.purge!

    puts 'Seeding players'
    seeder = Seeder.new(source: 'data/Master-small.csv', type: Player)
    seeder.populate
    puts "#{Player.count} added"

    puts 'Seeding battings'
    seeder = Seeder.new(source: 'data/Batting-07-12.csv', type: Batting)
    seeder.populate
    puts "#{Batting.count} added"

    puts 'Linking battings to players'
    Batting.link_to_player
  end
end
