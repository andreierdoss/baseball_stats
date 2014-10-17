require 'spec_helper'

describe Seeder do
  describe '#start' do
    let(:seeder) { Seeder.new({source: 'spec/fixtures/players.csv', type: Player}) }

    it 'inserts players' do
      expect { seeder.populate }.to change { Player.count }.from(0).to(2)
    end
  end
end
