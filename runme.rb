#!/usr/bin/env ruby

require './elf_reader'

ARGV.each do |filename|
  elfsystem = ElfReader.new(filename).read

  dirs = elfsystem.all_directories.find_all { |dir| dir.total_size <= 100000}
  puts "Directories which are at most 100k:"
  dirs.each { |d| puts "#{d.name} (#{d.total_size})" }
  puts "TOTAL: #{dirs.sum{|d| d.total_size}}"
end
