require 'spec_helper'

describe BattingAverageStat do
  let(:stat) { BattingAverageStat.new }

  describe '#most_improved' do
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

  describe '#triple_crown' do
    subject { stat.triple_crown('AL', 2012) }

    let(:player) { create(:player, first_name: 'First', last_name: 'Player') }
    let(:batting) { create(:batting, hits: hits, at_bats: at_bats, rbi: rbi, home_runs: home_runs, year: year, league: league) }

    before { player.battings << batting }

    context 'eligible player exists' do
      let!(:player_2) { create(:player, first_name: 'Second', last_name: 'Player') }
      let(:batting_2) { create(:batting, hits: 150, at_bats: 400, home_runs: 50, rbi: 100, year: 2012, league: 'AL') }

      before { player_2.battings << batting_2 }

      context 'at least 400 at bats, matching year, matching league and all 3 stats at max' do
        let(:at_bats) { 400 }
        let(:year) { 2012 }
        let(:league) { 'AL' }
        let(:hits) { 300 }
        let(:home_runs) { 100 }
        let(:rbi) { 200 }

        it { is_expected.to eq(player) }

        context 'not matching league' do
          let(:league) { 'NL' }

          it { is_expected.to eq(player_2) }
        end

        context 'not matching year' do
          let(:year) { 2011 }

          it { is_expected.to eq(player_2) }
        end

        context 'lower than 400 at bats' do
          let(:at_bats) { 399 }

          it { is_expected.to eq(player_2) }
        end

        context 'low hits' do
          let(:hits) { 100 }

          it { is_expected.to eq(nil) }
        end

        context 'low home runs' do
          let(:home_runs) { 49 }

          it { is_expected.to eq(nil) }
        end

        context 'low rbi' do
          let(:rbi) { 99 }

          it { is_expected.to eq(nil) }
        end
      end
    end

    context 'no eligible player' do
      let(:at_bats) { 399 }
      let(:year) { 2012 }
      let(:league) { 'AL' }
      let(:hits) { 300 }
      let(:home_runs) { 100 }
      let(:rbi) { 200 }

      it { is_expected.to eq(nil) }
    end
  end
end
