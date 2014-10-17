require 'spec_helper'

describe Batting do
  describe '.csv_to_mongo_keys' do
    let(:mapping) { {playerid: :player_external_id, yearid: :year, league: :league, teamid: :team, g: nil, ab: :at_bats, r: nil, 
                     h: :hits, '2b'.to_sym => :doubles, '3b'.to_sym => :triples, hr: :home_runs, rbi: :rbi, sb: nil, cs: nil} }
    subject { Batting.csv_to_mongo_keys }

    it { is_expected.to eq(mapping) }
  end

  describe '.link_to_player' do
    let!(:player) { create(:player, external_id: 'abc') }
    let!(:batting) { create(:batting, player_external_id: 'abc') }
    let!(:batting_2) { create(:batting, player_external_id: 'abc') }
    let!(:wrong_batting) { create(:batting, player_external_id: '123') }

    it 'adds battings to player' do
      expect { Batting.link_to_player }.to change { player.reload.battings.count }.from(0).to(2)
    end
  end

  describe '#calculate_average' do
    let(:batting) { create(:batting, batting_data) }

    subject { batting.avg }

    context 'data is present' do
      let(:batting_data) { {at_bats: 200, hits: 100} }
      it { is_expected.to eq(0.5) }
    end

    context 'at bats and hits are zero' do
      let(:batting_data) { {at_bats: 0, hits: 0} }

      it { is_expected.to eq(0) }
    end

    context 'at bats and hits are nil' do
      let(:batting_data) { {at_bats: nil, hits: nil} }

      it { is_expected.to eq(0) }
    end
  end

  describe '#calculate_slugging_percentage' do
    let(:batting) { create(:batting, batting_data) }

    subject { batting.slugging_percentage }

    context 'data is present' do
      let(:batting_data) { {hits: 100, doubles: 20, triples: 10, home_runs: 5, at_bats: 200} }
      it { is_expected.to eq(0.775) }
    end

    context 'at bats' do
      let(:batting_data) { {at_bats: 0} }

      it { is_expected.to eq(0) }
    end

    context 'at bats' do
      let(:batting_data) { {at_bats: nil} }

      it { is_expected.to eq(0) }
    end
  end
end
