require 'spec_helper'

describe SluggingPercentageStat do
  describe '#for_team_in' do

    let(:stat) { SluggingPercentageStat.new }
    let!(:player_1) { create(:player, :slugging_percentage_team_player_1) }
    let!(:player_2) { create(:player, :slugging_percentage_team_player_2) }
    let(:team) { [ {player: player_1, slugging_percentage: 0.775 }, {player: player_2, slugging_percentage: 0.775} ] }
    subject { stat.for_team_in('OAK', 2007) }

    it { is_expected.to eq(team) }
  end
end
