require './spec/spec_helper.rb'

describe 'Describes owner_repo' do
  let(:create_owner) { Owner.new('A', 'a', 'male') }

  context 'owner.yml file is overridden' do
    let(:filename) { 'test' }
    let(:save_info) { save_owners(create_owner, filename) }
    after :each do
      File.delete("./config/#{filename}.yml")
    end

    it 'info should be same' do
      save_info
      expect(get_all(filename).name).to eq('A')
    end
  end

  context 'Passed team name is original' do
    let(:same_name) { 'team1' }
    let(:diff_name) { 'winnerTeam' }
    let(:init_teams) {
      create_owner.create_team('team1')
      create_owner.create_team('team2')
    }

    it 'should return true' do
      init_teams
      expect(original([create_owner], diff_name)).to be_truthy
    end

    it 'should return false' do
      init_teams
      expect(original([create_owner], same_name)).to be false
    end
  end
end
