#!/usr/bin/env ruby

## Level 1 markov model. for level 2+, make markov_state's lists of eg [-2, -1].
#also random_donnerism will not work as written for 2+

require './Donnerisms'
require 'pry'

module Donnerator
  class MarkovModel
    def initialize
      @substitutions = {
        you: "ya",
        nothing: "nothin",
        am: "are",
        are: "be",
        is: "be",
        me: "i",
        youll: "you'll",
        that: "dat",
        we: "I an I",
        and: "an"
      }
      @markov = Hash.new { |h,k| h[k] = []} # hash of keys to lists
      isms = Donnerisms::Isms.new.isms
      isms.each do |i|
        tokens = tokenize(i)
        until tokens.empty?
          token = tokens.pop
          markov_state = tokens[-1] #[tokens[-2], tokens[-1]]
          @markov[markov_state] << token
        end
      end
    end

    def random_donnerism(min_length: 2, max_length: 12)
      tokens = [@markov.keys.sample]  # start at random token
      until sentence_complete?(tokens, min_length, max_length)
        markov_state = tokens[-1]
        tokens << @markov[markov_state].sample
      end
      replace_words(tokens)
    end

    def replace_words(tokens)
      tokens.map do |w|
        r = @substitutions.fetch(w, w)  # default is original
        (rand(2) == 1) ? r.to_s : w  # only replace half of the time
      end . join(' ').strip
    end

    def tokenize(sentence)
      return [] if sentence.nil? || sentence.length == 0
      sentence.split(' ').map(&:downcase.to_sym)
    end


    def sentence_complete?(tokens, min_length, max_length)
      tokens.last =~ /\.\z/
    end

    # def sentence_complete?(tokens, min_length, max_length)
    #   tokens.length >= max_length || tokens.length >= min_length &&
    #     (tokens.last.nil? || tokens.last =~ /\.\z/)
    # end

  end
end

puts Donnerator::MarkovModel.new.random_donnerism
