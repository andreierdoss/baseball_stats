class SluggingPercentageStatViewer
  def initialize(stat)
    @stat = stat
  end

  def display_slugging_percentage team, year
    team_stats = @stat.for_team_in(team, year)
    if team_stats.present?
      ["Slugging percentage for #{team} in #{year}", display_team(team_stats)].join("\n")
    else
      "No eligible players found."
    end
  end

  private
  def display_team team_stats
    team_stats.map {|team_stat| "#{team_stat[:player].name} - #{format_percentage(team_stat[:slugging_percentage])}"}.join("\n")
  end

  def format_percentage percentage
    percentage.round(3)
  end
end
