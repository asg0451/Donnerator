#!/usr/bin/env ruby

require 'pry'


module Donnerisms
  class Isms
    attr_reader :isms
    def initialize
      @isms = []
      readIsms
    end
    def readIsms
      contents = File.open('donnerisms.txt').read
      @isms = contents.split(/\n/)
    end
  end
end

#binding.pry

# d = Donnerisms::Isms.new
# d.isms.each do |l|
#   puts l
# end
