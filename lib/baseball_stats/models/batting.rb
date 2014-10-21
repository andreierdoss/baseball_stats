require 'mongoid'

class Batting
  include Mongoid::Document
  field :player_external_id, type: String
  field :year, type: Integer
  field :league, type: String
  field :team, type: String
  field :at_bats, type: Integer
  field :hits, type: Integer
  field :doubles, type: Integer
  field :triples, type: Integer
  field :home_runs, type: Integer
  field :rbi, type: Integer
  field :avg, type: Float
  field :slugging_percentage, type: Float
  index({avg: 1})
  index({home_runs: 1})
  index({rbi: 1})
  belongs_to :player
  before_create :calculate_average
  before_create :calculate_slugging_percentage

  def self.csv_to_mongo_keys
     {playerid: :player_external_id, yearid: :year, league: :league, teamid: :team, g: nil, ab: :at_bats, r: nil,
      h: :hits, '2b'.to_sym => :doubles, '3b'.to_sym => :triples, hr: :home_runs, rbi: :rbi, sb: nil, cs: nil}
  end

  def calculate_average
    self.avg = valid_for_average? ? 0 : (hits.to_f / at_bats.to_f)
  end

  def calculate_slugging_percentage
    self.slugging_percentage = valid_for_slugging_percentage? ? 0 : ((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end

  def self.link_to_player
    Batting.all.group_by(&:player_external_id).each do |external_id, battings|
      player = current_player(external_id)
      player.battings << battings if player.present?
    end
  end

  private
  def self.current_player external_id
    Player.where(external_id: external_id).first
  end

  def valid_for_slugging_percentage?
    at_bats.blank? || at_bats.zero?
  end

  def valid_for_average?
    at_bats.blank? || hits.blank? || at_bats.zero?
  end
end
