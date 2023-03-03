class ElfDirectory
  attr_reader :name, :parent
  attr_accessor :directories, :files

  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @directories = {}
    @files = []
  end

  def add_directory(dirname)
    directories[dirname] = ElfDirectory.new(dirname, self)
  end

  def get_directory(dirname)
    directories[dirname]
  end

  def add_file(size, name)
    files << ElfFile.new(size, name)
  end

  def total_size
    @total_size ||= directories.values.sum{|d| d.total_size} + files.sum{|f| f.size}
  end

  def all_directories
    [self] + directories.values.map(&:all_directories).flatten
  end

end
