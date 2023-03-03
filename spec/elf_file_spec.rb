require_relative '../elf_file'

RSpec.describe ElfFile do
  let(:file) { described_class.new('12345', 'filename') }

  describe 'size' do
    subject { file.size }
    it { is_expected.to eql(12345) }
  end

  describe 'name' do
    subject { file.name }
    it { is_expected.to eql('filename') }
  end
end
