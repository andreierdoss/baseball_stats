class SluggingPercentageStat
  def for_team_in team, year
    battings_for_team_year(team, year).map do |batting|
      {player: batting.player, slugging_percentage: batting.slugging_percentage}
    end
  end

  private
  def battings_for_team_year team, year
    Batting.where(team: team, year: year)
  end
end
