require './elf_directory'
require './elf_file'

class ElfReader
  attr_reader :elfsystem, :filename

  def initialize(filename)
    @filename = filename
    @elfsystem = ElfDirectory.new('/')
  end

  def read
    current = elfsystem
    puts "Processing file: #{filename}..."
    File.read(filename).each_line do |line|
      case line
      when /^\$ cd \//
        # change to root
        current = elfsystem
      when /^\$ cd \.\./
        # change to parent
        current = current.parent
      when /^\$ cd .+/
        # change to subdirectory
        current = current.get_directory(line.split(' ')[2])
      when /^\$ ls/
        # initiate listing files
      when /^dir/
        # add directory
        current.add_directory(line.split(' ')[1])
      else
        # add file
        current.add_file(*line.split(' '))
      end
    end
    elfsystem
  end
end
