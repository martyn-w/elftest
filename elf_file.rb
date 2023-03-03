class ElfFile
  attr_reader :name, :size

  def initialize(size, name)
    @name = name
    @size = size.to_i
  end
end
