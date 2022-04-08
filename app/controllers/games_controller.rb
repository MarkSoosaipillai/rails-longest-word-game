require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(" ").upcase
  end

  def letter_exist
    @answer.chars.all? do
      |letter| @grid.include?(letter)
    end
    raise
  end
  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end
  def score
    @answer = params[:word]
    @grid = params[:grid]
    if !letter_exist
      @result = "#{@answer} doesn't exist in #{@grid.chars.join(" ")}."
    elsif !english_word || (!english_word && letter_exist)
      @result = "#{@answer} isn't an English word."
    else
      @result = "Congrats! #{@answer} is valid"
    end
  end
end
