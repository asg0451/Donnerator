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
      @isms = contents.split(/\n/)
    end
  end
end
