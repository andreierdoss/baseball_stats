class BattingAverageStat
  MIN_AT_BATS = 200
  TC_MIN_AT_BATS = 400

  def most_improved from, to
    results = grouped_battings.map do |player, battings|
      {player: player, difference: difference_avg(battings)} if battings.count == 2
    end.compact
    max_difference(results) if results
  end

  def triple_crown league, year
    avg, home_runs, rbi = triple_crown_max_values(league, year)
    batting = triple_crown_batting(league: league, year: year, avg: avg, home_runs: home_runs, rbi: rbi).first
    batting.player if batting
  end

  private
  def triple_crown_max_values league, year
    avg = triple_crown_eligible_battings(league, year).max(:avg)
    home_runs  = triple_crown_eligible_battings(league, year).max(:home_runs)
    rbi = triple_crown_eligible_battings(league, year).max(:rbi)
    [avg, home_runs, rbi]
  end

  def triple_crown_batting args={}
    triple_crown_eligible_battings(args[:league], args[:year]).
      where(avg: args[:avg], home_runs: args[:home_runs], rbi: args[:rbi])
  end

  def grouped_battings
    descending_order_battings.group_by(&:player)
  end

  def descending_order_battings
    most_improved_eligible_battings.order(year: -1)
  end

  def triple_crown_eligible_battings league, year
    Batting.where(league: league, year: year).gte(at_bats: TC_MIN_AT_BATS)
  end

  def most_improved_eligible_battings
    Batting.in(year: [2009, 2010]).gte(at_bats: MIN_AT_BATS)
  end

  def difference_avg battings
    battings.first.avg - battings.last.avg
  end

  def max_difference results
    results.max_by {|result| result[:difference]}
  end
end
