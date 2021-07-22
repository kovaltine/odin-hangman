# frozen_string_literal: true

require 'yaml'
require 'colorize'

# updates the display in the console according to the gameplay
module Display
  def masked_positions(word)
    position_arr = word.split('')
    position_arr.map { |_position| _position = '_' }.join
  end

  def starting_message
    puts "\n"
    puts '  Welcome to Hangman  '.colorize(:yellow).on_black.underline
  end

  def update_display
    puts "\n"
    puts @masked_word
    puts "Letters tried: #{@letters_tried} ".colorize(:blue)
    puts "You have #{@guesses_remaining} guesses remaining".colorize(:red)
  end

  def try_another_letter
    puts "\nI'm sorry, you've already tried that letter".colorize(:red)
    puts "Here's the list: #{@letters_tried}".colorize(:light_blue)
    puts 'Please try again'.colorize(:light_blue)
  end

  def invalid_data
    puts 'Sorry, you need to type in a single letter, not a number or anything else'.colorize(:red)
    puts 'Please try again'.colorize(:light_blue)
  end

  def won_game
    puts "\nCongratulations, you won! :)".colorize(:yellow)
  end

  def lost_game
    puts "\nSorry, you lost :(".colorize(:red).on_black.underline
    puts "The word was: #{@word}"
  end

  def display_saved_end
    puts 'file has been saved'.colorize(:red)
  end

  def display_end
    puts "\nThanks for playing my game!".colorize(:yellow)
  end
end
