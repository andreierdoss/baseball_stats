require 'spec_helper'

describe SluggingPercentageStatViewer do
  describe '#display_slugging_percentage' do
    let!(:player_1) { create(:player, first_name: 'Jane', last_name: 'Lane') }
    let!(:player_2) { create(:player, first_name: 'Mary', last_name: 'Poppins') }
    let(:stat) { SluggingPercentageStat.new }
    let(:stat_viewer) { SluggingPercentageStatViewer.new(stat) }

    before do
      allow(stat).to receive(:for_team_in).with('OAK', 2007) { team }
    end

    subject { stat_viewer.display_slugging_percentage('OAK', 2007) }

    context 'with result' do
      let(:team) { [{player: player_1, slugging_percentage: 0.7754321}, {player: player_2, slugging_percentage: 0.654678}] }

      it { is_expected.to eq("Slugging percentage for OAK in 2007\nJane Lane - 0.775\nMary Poppins - 0.655") }
    end

    context 'without result' do
      let(:team) { nil }

      it { is_expected.to eq("No eligible players found.") }
    end
  end
end
