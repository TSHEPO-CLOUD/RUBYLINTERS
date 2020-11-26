#!/usr/bin/env ruby
require_relative "../lib/testcase"
require_relative "../lib/arleterrors"
require_relative "../lib/gettingerrors"

lint = Test.new(ARGV[0])
if lint.file_name
  puts "Hello, welcome to Ruby linter!"
else
  abort "Enter the valid file name from data folder"
end

lint.read_file
lint.content.each_with_index do |line, index|
  find_error = CheckErrors.new(line, index)
  puts AlertErrors.new.raise_an_error(1, index) if find_error.check_whitespaces?
  puts AlertErrors.new.raise_an_error(2, index) if find_error.check_length?
  puts AlertErrors.new.raise_an_error(3, index) if find_error.check_parentes_count?
  puts AlertErrors.new.raise_an_error(4, index) if find_error.check_bracket_count?
  puts AlertErrors.new.raise_an_error(5, index) if find_error.check_curly_count?
end
puts Rainbow("No offences detected").blue if ObjectSpace.each_object(RaisingErrors).count.zero?
