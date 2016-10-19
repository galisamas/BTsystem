require './spec/spec_helper.rb'

describe Team do
  let(:init_team) do
    described_class.new('a', nil)
  end

  let(:init_coach) do
    Coach.new('1', '1', 'female')
  end

  it 'has 1 coach' do
    init_team.add_coach(init_coach)
    expect(init_team.coach_count).to be(1)
  end

  it 'still has 1 coach' do
    init_team.add_coach(init_coach)
    init_team.add_coach(init_coach)
    expect(init_team.coach_count).to be(1)
  end
end
