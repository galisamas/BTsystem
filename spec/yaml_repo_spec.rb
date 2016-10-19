require './spec/spec_helper.rb'

describe 'Describes yaml_repo' do
  let(:create_owner) { Owner.new('A', 'a', 'male') }

  context '.yml file' do
    let(:filename) { 'test' }
    let(:save_info) { save_all(create_owner, filename) }
    after :each do
      File.delete("./config/#{filename}.yml")
    end

    it 'info should be same' do
      save_info
      expect(get_all(filename).name).to eq('A')
    end
  end

  context 'load owner with teams' do
    let(:same_name) { 'team1' }
    let(:diff_name) { 'winnerTeam' }
    let(:init_teams) {
      create_owner.create_team('team1')
      create_owner.create_team('team2')
    }
    let(:init_coach) { Coach.new('coach1', 'coach', 'female') }
    let(:init_player) { Player.new('player1', 'player', 'female', 99) }

    after :all do
      File.delete("./config/.yml")
    end

    it 'should return true' do
      init_teams
      expect(original([create_owner], diff_name)).to be_truthy
    end

    it 'should return false' do
      init_teams
      expect(original([create_owner], same_name)).to be false
    end

    context 'authentic process' do

      it 'should return success in creating team' do
        init_teams
        expect { menu_create_team_process(0, diff_name, [create_owner]) }.to output("team was successfully added\n").to_stdout
      end

      it 'should return fail in creating team' do
        init_teams
        expect { menu_create_team_process(0, same_name, [create_owner]) }.to output("team name team1 already exist\n").to_stdout
      end

      it 'should return success in changing teams name' do
        init_teams
        expect { menu_change_team_name_process( 0, 0, diff_name, [create_owner]) }.to output("team name was successfully changed to winnerTeam\n").to_stdout
      end

      it 'should return fail in changing teams name' do
        init_teams
        expect { menu_change_team_name_process( 0, 0, same_name, [create_owner]) }.to output("team name team1 already exist\n").to_stdout
      end
    end

    context 'hiring coach to team' do

      it 'hires coach successfully' do
        init_teams
        expect { menu_hire_coach_process([create_owner], 0, [init_coach], 0, 1) }.to output("coach1 was successfully hired\n").to_stdout
      end

      it 'coach hiring failed' do
        init_teams
        create_owner.hire_coach('team2', init_coach)
        expect { menu_hire_coach_process([create_owner], 0, [init_coach], 0, 1) }.to output("coach1 is already team2's coach\n").to_stdout
      end
    end

    context 'firing coach' do

      it 'fires coach successfully' do
        init_teams
        create_owner.hire_coach('team2', init_coach)
        expect { menu_fire_coach_process([create_owner], 0, [], 0, 1) }.to output("coach1 was successfully fired\n").to_stdout
      end
    end

    context 'hiring player to team' do

      it 'hires player successfully' do
        init_teams
        expect { menu_hire_player_process([create_owner], 0, [init_player], 0, 1) }.to output("player1 was successfully hired\n").to_stdout
      end

      it 'player hiring failed' do
        init_teams
        create_owner.hire_player('team2', init_player)
        expect { menu_hire_player_process([create_owner], 0, [init_player], 0, 1) }.to output("player1 is already team2's player\n").to_stdout
      end
    end

    context 'firing player' do

      it 'fires coach successfully' do
        init_teams
        create_owner.hire_player('team2', init_player)
        expect { menu_fire_player_process([create_owner], 0, [], 0, 1) }.to output("player1 was successfully fired\n").to_stdout
      end
    end

    context 'changing coach level' do

      it 'should change to head level successfully' do
        init_teams
        create_owner.hire_coach('team2', init_coach)
        expect { menu_change_coach_level_process([create_owner], 0, 0, 1, 'head') }.to output("level was changed successfully\n").to_stdout
      end

      it 'should fail in changing level' do
        init_teams
        create_owner.hire_coach('team2', init_coach)
        expect { menu_change_coach_level_process([create_owner], 0, 0, 1, 'assistant') }.to output("assistant level was the same\n").to_stdout
      end
    end
  end
end
