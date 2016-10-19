require './spec/spec_helper.rb'

describe Owner do
  let(:create_owner) { described_class.new('A', 'a', 'male') }
  let(:team_old_name) { 'Team1' }
  let(:team_new_name) { 'New Name' }
  let(:create_team_to_owner) { create_owner.create_team(team_old_name) }

  context 'when owner A creates the team' do
    it 'returns A\'s ID' do
      create_team_to_owner
      expect(create_owner.newest_team.owner).to eql(create_owner)
    end

    it 'returns newest created team' do
      create_team_to_owner
      expect(create_owner.newest_team.name).to eql(team_old_name)
    end

    it 'changes the name to "newName"' do
      create_team_to_owner
      create_owner.change_team_name(team_old_name, team_new_name)
      expect(create_owner.newest_team.name).to eql(team_new_name)
    end
  end

  context 'owner' do
    let(:owner_info) { 'I\'m A a, male and I have 1 team(s). Contacts:  .' }
    let(:correct_email) { 'a@a.com' }
    let(:correct_phone) { '+370 111 11111' }
    let(:incorect_email) { '@.com' }
    let(:incorrect_phone) { '112' }

    it 'correct personal info' do
      create_team_to_owner
      expect(create_owner.to_s).to eql(owner_info)
    end

    it 'owns 1 team' do
      create_team_to_owner
      expect(create_owner.owned_team_count).to be(1)
    end

    it 'has no email' do
      create_owner.set_email(incorect_email)
      expect(create_owner.contact.email).to eql('')
    end

    it 'has a@a.com email' do
      create_owner.set_email(correct_email)
      expect(create_owner.contact.email).to eql(correct_email)
    end

    it 'has no phone number' do
      create_owner.set_phone(incorrect_phone)
      expect(create_owner.contact.phone).to eql('')
    end

    it 'has +370 111 11111 number' do
      create_owner.set_phone(correct_phone)
      expect(create_owner.contact.phone).to eql(correct_phone)
    end
  end

  context 'team roster' do
    let(:create_coach) { Coach.new('1', '1', 'female') }

    it 'hire new coach' do
      create_team_to_owner
      create_owner.hire_coach(team_old_name, create_coach)
      expect(create_owner.team_coach_count(team_old_name)).to be(1)
    end

    it 'fire coach' do
      create_team_to_owner
      create_owner.hire_coach(team_old_name, create_coach)
      create_owner.fire_coach(team_old_name, 0)
      expect(create_owner.team_coach_count(team_old_name)).to be(0)
    end
  end
end
