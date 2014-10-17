class BattingAverageStat
  MIN_AT_BATS = 200

  def most_improved from, to
    results = grouped_battings.map do |player, battings|
      {player: player, difference: difference_avg(battings)} if battings.count == 2
    end.compact
    max_difference(results) if results
  end

  private
  def grouped_battings
    descending_order_battings.group_by(&:player)
  end

  def descending_order_battings
    eligible_battings.order(year: -1)
  end

  def eligible_battings
    Batting.in(year: [2009, 2010]).gte(at_bats: MIN_AT_BATS)
  end

  def difference_avg battings
    battings.first.avg - battings.last.avg
  end

  def max_difference results
    results.max_by {|result| result[:difference]}
  end
end
