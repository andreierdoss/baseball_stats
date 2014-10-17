FactoryGirl.define do
  factory :player do
    external_id '123'
    first_name 'Bob'
    last_name 'Smith'

    trait :most_improved_batting_average do
      external_id 'most_improved'
      first_name 'Most'
      last_name 'Improved'
      after(:create) do |instance|
        instance.battings << [create(:batting, year: 2009, at_bats: 200, hits: 50), create(:batting, year: 2010, at_bats: 200, hits: 100 )]
      end
    end

    trait :low_at_bats_most_improved_batting_average do
      external_id 'low_at_bats'
      first_name 'Low'
      last_name 'At bats'
      after(:create) do |instance|
        instance.battings << [create(:batting, year: 2009, at_bats: 100, hits: 25 ), create(:batting, year: 2010, at_bats: 100, hits: 75 )]
      end
    end

    trait :low_improvement_batting_average do
      external_id 'low_improvement'
      first_name 'Low'
      last_name 'Improvement'
      after(:create) do |instance|
        instance.battings << [create(:batting, year: 2009, at_bats: 200, hits: 100), create(:batting, year: 2010, at_bats: 200, hits: 99)]
      end
    end

    trait :missing_data_batting_player do
      external_id 'missing_data'
      first_name 'Missing'
      last_name 'Data'
      after(:create) do |instance|
        instance.battings << create(:batting, year: 2009, at_bats: 200, hits: 101)
      end
    end

    trait :slugging_percentage_team_player_1 do
      external_id 'player_1'
      first_name 'Slugger'
      last_name 'One'
      after(:create) do |instance|
        instance.battings << build(:batting, year: 2007, team: 'OAK', hits: 100, doubles: 20, triples: 10, home_runs: 5, at_bats: 200)
      end
    end

    trait :slugging_percentage_team_player_2 do
      external_id 'player_2'
      first_name 'Slugger'
      last_name 'Two'
      after(:create) do |instance|
        instance.battings << build(:batting, year: 2007, team: 'OAK', hits: 200, doubles: 40, triples: 20, home_runs: 10, at_bats: 400)
      end
    end
  end

  factory :batting do
    player_external_id '123'
    year 2009
    league 'AL'
    team 'OAK'
    at_bats 230
    hits 100
    doubles 30
    triples 5
    home_runs 20
    rbi 100
  end
end
