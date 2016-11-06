#!/usr/bin/env ruby

module Donnerisms
  class Isms
    attr_reader :isms
    def initialize
      @isms = []
      readIsms
    end
    def readIsms
      contents = File.open('donnerisms.txt').read
      @isms = contents.split(/\n/).select { |l|  !l.start_with?("#") }
    end
  end
end

# Donnerisms::Isms.new.readIsms.map { |i| puts i } # test
