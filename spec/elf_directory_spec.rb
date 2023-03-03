require_relative '../elf_directory'

RSpec.describe ElfDirectory do
  let(:root) { described_class.new('/', nil) }
  let(:dir) { described_class.new('dirname', root) }

  describe 'get_directory' do
    before do
      root.directories['dirname'] = dir
    end

    subject { root.get_directory('dirname') }
    it { is_expected.to eql(dir) }
  end

  describe 'add_directory' do
    before do
      root.add_directory('dirname')
    end

    subject { root.directories['dirname'] }
    it { is_expected.to be_a ElfDirectory }
  end

  describe 'add_file' do
    before do
      root.add_file('12345', 'filename')
    end

    subject { root.files.first }
    it { is_expected.to be_a ElfFile }
  end

  describe 'total_size' do
    before do
      root.add_file('1', 'file1')
      root.add_file('2', 'file2')
      root.add_directory('dir')
      root.directories['dir'].add_file('3', 'file3')
    end

    subject { root.total_size }
    it { is_expected.to eql(6) }
  end

  describe 'all_directories' do
    before do
      root.add_directory('dir')
      root.directories['dir'].add_file('3', 'file3')
      root.directories['dir'].add_directory('dir2')
    end

    subject { root.all_directories.map{ |d| d.name } }
    it { is_expected.to match_array(['/', 'dir', 'dir2']) }
  end
end
