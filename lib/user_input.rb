# frozen_string_literal: true

require './display'
require 'colorize'

# takes in and modifies user input
module User
  def find_word
    word_list = IO.readlines('5desk.txt')
    word_list.each(&:strip!).select { |word| word.length.between?(5, 12) }
    word_list[rand(0..word_list.length)].downcase
  end

  def input_letter
    puts "Guess a letter, or type 'save' to save your game".colorize(:light_blue)
    letter = gets.chomp.downcase
    if letter == 'save'
      save_file
      keep_playing
    else
      check_data(letter)
    end
  end

  def check_data(letter)
    if @letters_tried.include?(letter)
      try_another_letter
      input_letter
    elsif letter.length == 1 && /[a-z]/.match?(letter)
      @letters_tried.push(letter)
      check_letter(letter)
    else
      invalid_data
      input_letter
    end
  end

  def check_letter(letter)
    if @word.include? letter
      position = []
      word = @word.split('')
      word.map.with_index do |char, index|
        position.push(index) if char == letter
      end
      correct_guess(position, letter)
    else
      @guesses_remaining -= 1
    end
  end

  def correct_guess(position, letter)
    position.each do |pos|
      @masked_word.slice!(pos)
      @masked_word.insert(pos, letter)
    end
  end

  def play_again?
    puts "\nWould you like to play another game?".colorize(:light_blue)
    puts "Enter 'y' if you want to play again".colorize(:light_blue)
    answer = gets.chomp.downcase
    answer == 'y'
  end

  def keep_playing
    puts 'Would you like to keep playing? y/n'.colorize(:light_blue)
    answer = gets.chomp.downcase
    if answer == 'y'
      nil
    else
      @guesses_remaining = 0
      @play_again = false
    end
  end
end
