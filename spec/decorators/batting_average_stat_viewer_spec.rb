require 'spec_helper'

describe BattingAverageStatViewer do
  describe '#display_most_improved' do
    let(:player) { build(:player, first_name: 'Jane', last_name: 'Lane') }
    let(:stat) { BattingAverageStat.new }
    let(:stat_viewer) { BattingAverageStatViewer.new(stat) }

    before do
      allow(stat).to receive(:most_improved).with(2000, 2001) { most_improved_result }
    end

    subject { stat_viewer.display_most_improved(2000, 2001) }

    context 'with result' do
      let(:most_improved_result) { {player: player, difference: 0.5} }

      it { is_expected.to eq("The player with the most improved batting average from 2000 to 2001 is Jane Lane") }
    end

    context 'without result' do
      let(:most_improved_result) { nil }

      it { is_expected.to eq("No eligible players found.") }
    end
  end
end
