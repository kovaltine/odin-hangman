# frozen_string_literal: true

require './database'

# start and run the game using modules from other files
class Game
  include Display
  include User
  include Database

  def initialize
    @play_again = true
    @filenames = []
    start
    display_end
  end

  def start
    while @play_again
      starting_message
      @guesses_remaining = 10
      @word = find_word
      @masked_word = masked_positions(@word)
      @letters_tried = []
      run_game
      play_again? ? start : @play_again = false
    end
  end

  def run_game
    load_game?
    while @guesses_remaining.positive?
      update_display
      if solved?
        @guesses_remaining = 0
      else
        input_letter
      end
    end
    if @play_again == false
      nil
    else
      solved? ? won_game : lost_game
    end
  end

  def solved?
    @masked_word == @word
  end

  def load_game?
    puts 'would you like to load a game from before? y/n'.colorize(:light_blue)
    load_game if gets.chomp.downcase == 'y'
  end
end
