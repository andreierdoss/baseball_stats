require 'spec_helper'

describe BattingAverageStat do
  describe '#most_improved' do
    let(:stat) { BattingAverageStat.new }
    subject { stat.most_improved(2009, 2010) }

    context 'eligible players' do
      let!(:most_improved_player) { create(:player, :most_improved_batting_average) }
      let!(:low_improvement_player) { create(:player, :low_improvement_batting_average) }

      it { is_expected.to eq({player: most_improved_player, difference: 0.25}) }
    end

    context 'ineligible player, yet most improved' do
      let!(:low_at_bats_most_improved_player) { create(:player, :low_at_bats_most_improved_batting_average) }

      it { is_expected.to eq(nil) }
    end

    context 'missing 2010 batting' do
      let!(:missing_data_player) { create(:player, :missing_data_batting_player) }

      it { is_expected.to eq(nil) }
    end
  end
end
