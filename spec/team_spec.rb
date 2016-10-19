require './spec/spec_helper.rb'

describe Team do
  let(:init_team){ described_class.new('a', nil) }

  context 'team coaches' do
    let(:init_coach){ Coach.new('1', '1', 'female') }

    it 'should have 1 coach after adding 1' do
      init_team.add_coach(init_coach)
      expect(init_team.coach_count).to be(1)
    end

    it 'should have 1 coach after adding same 2' do
      init_team.add_coach(init_coach)
      init_team.add_coach(init_coach)
      expect(init_team.coach_count).to be(1)
    end

    it 'should have 0 coach after deleting 1' do
      init_team.add_coach(init_coach)
      init_team.delete_coach_at(0)
      expect(init_team.coach_count).to be(0)
    end
  end
  context 'team players' do
    let(:init_player) { Player.new('1', '1', 'male', '99') }
    it 'should have 1 player after adding 1' do
      init_team.add_player(init_player)
      expect(init_team.player_count).to be(1)
    end

    it 'should have 1 player after adding same 2' do
      init_team.add_player(init_player)
      init_team.add_player(init_player)
      expect(init_team.player_count).to be(1)
    end

    it 'should have 0 player after deleting 1' do
      init_team.add_player(init_player)
      init_team.delete_player_at(0)
      expect(init_team.player_count).to be(0)
    end
  end
end
