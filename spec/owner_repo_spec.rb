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
    context 'authentic process' do
      after :each do
        File.delete("./config/.yml")
      end
      it 'should return success in creating team' do
        init_teams
        expect { menu_create_team_process(0, diff_name, [create_owner]) }.to output("team was successfully added\n").to_stdout
      end

      it 'should return success in changing teams name' do
        init_teams
        expect { menu_change_team_name_process( 0, 0, diff_name, [create_owner]) }.to output("team name was successfully changed to winnerTeam\n").to_stdout
      end
    end
  end
end
