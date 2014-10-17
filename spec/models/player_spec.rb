require 'spec_helper'

describe Player do
  describe '.csv_to_mongo_keys' do
    subject { Player.csv_to_mongo_keys }

    it { is_expected.to eq({playerid: :external_id, birthyear: nil, namefirst: :first_name, namelast: :last_name}) }
  end

  describe '#name' do
    let(:player) { create(:player, first_name: 'Marky', last_name: 'Mark') }

    subject { player.name }

    it { is_expected.to eq('Marky Mark') }
  end
end
