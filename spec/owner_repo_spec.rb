require './spec/spec_helper.rb'

describe 'Describes owner_repo' do
  let(:create_owner) { Owner.new('A', 'a', 'male') }
  let(:filename) { 'test' }
  let(:save_info) { save_owners(create_owner, filename) }

  context 'owner.yml file is overridden' do
    after :each do
      File.delete("./config/#{filename}.yml")
    end

    it 'info should be same' do
      save_info
      expect(get_all(filename).name).to eq('A')
    end
  end

end