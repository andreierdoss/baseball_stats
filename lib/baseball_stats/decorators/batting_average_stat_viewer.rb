class BattingAverageStatViewer
  def initialize(stat)
    @stat = stat
  end

  def display_most_improved from, to
    most_improved = @stat.most_improved(from, to)
    if most_improved.present?
      "The player with the most improved batting average from #{from} to #{to} is #{most_improved[:player].name}"
    else
      "No eligible players found."
    end
  end

  def display_triple_crown_winner league, year
    triple_crown = @stat.triple_crown(league, year)
    if triple_crown
      "The #{year} #{league} triple crown winner is #{triple_crown.name}."
    else
      "No winner for #{year} #{league}."
    end
  end
end
