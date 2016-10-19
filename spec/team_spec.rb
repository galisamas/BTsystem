require './spec/spec_helper.rb'

describe Team do
  let(:init_team) do
    described_class.new('a', nil)
  end

  let(:init_coach) do
    Coach.new('1', '1', 'female')
  end

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
    init_team.delete_at(0)
    expect(init_team.coach_count).to be_empty
  end
end
