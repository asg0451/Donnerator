#!/usr/bin/env ruby

require './Donnerisms'
require 'pry'

module MModel

  class MarkovModel
    def initialize

      @repl_words = {
        you: "ya",
        nothing: "nothin",
        are: "be",
        is: "be",
        me: "i"
      }

      @markov_model = Hash.new { |h,k| h[k] = []} # hash of keys to lists
      isms = Donnerisms::Isms.new.isms
      isms.each do |i|
        tokens = tokenize(i)
        until tokens.empty?
          token = tokens.pop
          markov_state = tokens[-1] #[tokens[-2], tokens[-1]]
          @markov_model[markov_state] << token
        end
      end
    end

    def complete_sentence(sentence = '', min_length: 2, max_length: 10)


      tokens = tokenize(sentence)
      # binding.pry
      until sentence_complete?(tokens, min_length, max_length)
        markov_state = tokens[-1]   # [tokens[-2], tokens[-1]]
        tokens << @markov_model[markov_state].sample
      end

      tokens.map do |w|
        r = @repl_words.fetch(w, w)  # default is original
        (rand(2) == 1) ? r.to_s : w
      end . join(' ').strip

    end

    def tokenize(sentence)
      return [] if sentence.nil? || sentence.length == 0
      sentence.split(' ').map { |word| word.downcase.to_sym }
    end

    def sentence_complete?(tokens, min_length, max_length)
      tokens.length >= max_length || tokens.length >= min_length &&
        (tokens.last.nil? || tokens.last =~ /[\!\?\.]\z/)
    end

  end
end

puts MModel::MarkovModel.new.complete_sentence(gets.chomp)
