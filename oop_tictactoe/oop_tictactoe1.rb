# OOP TIC-TAC-TOE V1

require 'pry'

class Board
  attr_accessor :tic_tac_toe_spaces

  def initialize
    @tic_tac_toe_spaces = {1 => ' ', 2 => ' ', 3 => ' ',
                          4 => ' ', 5 => ' ', 6 => ' ',
                          7 => ' ', 8 => ' ', 9 => ' '}
  end

  def draw_board
    system ("clear")
    puts " " + @tic_tac_toe_spaces[1] + " | " + @tic_tac_toe_spaces[2] + " | " + @tic_tac_toe_spaces[3] + " "
    puts "---+---+---"
    puts " " + @tic_tac_toe_spaces[4] + " | " + @tic_tac_toe_spaces[5] + " | " + @tic_tac_toe_spaces[6] + " "
    puts "---+---+---"
    puts " " + @tic_tac_toe_spaces[7] + " | " + @tic_tac_toe_spaces[8] + " | " + @tic_tac_toe_spaces[9] + " "
  end

  def space_open_for_mark?(location)
    if tic_tac_toe_spaces[location] == ' '
      true
    else
      false
    end
  end

  def mark_player_on_board(location)
    begin
      if space_open_for_mark?(location)
        tic_tac_toe_spaces[location] = 'X'
      else
        puts "Please choose an open space."
      end
    end

  end

  def mark_computer_on_board(location)
    tic_tac_toe_spaces[location] = 'O'
  end

  def clear_board_for_new_game(board_spaces)
    board_spaces.collect do |key, value|
      board_spaces[key] = ' '
    end
  end


end


# class CoinTossIntro
#   def initialize
#     puts "We are going to flip a coin to decide who goes first."
#     @player_coin_guess = ''
#     @coin_flip_result = ''
#     @coin_sides = ['H', 'T']
#     computer_starts = false
#   end

#   def player_guesses_coin_flip
#     begin
#       puts "Please choose Heads or Tails (H/T)"
#       @player_coin_guess = gets.chomp.upcase
#     end until @coin_sides.include?(@player_coin_guess)
#   end

#   def player_wins_coin_toss?
#     @coin_flip_result = @coin_sides.sample
#     puts "You chose #{@player_coin_guess}, the toss comes up #{@coin_flip_result}"
#     if @player_coin_guess != @coin_flip_result
#       false
#     else
#       true
#     end
#   end

#   def run
#     player_guesses_coin_flip
#     player_wins_coin_toss?
#   end
# end


class Player
  attr_accessor :space_choice

  def intialize
    @player_space_choice = 0
  end

  def player_chooses_space
    begin
      puts "Please choose a space by entering a number 1-9..."
      player_space_choice = gets.chomp.to_i
    end until (1..10).include?(player_space_choice)
    player_space_choice
  end
end


class Computer
  attr_accessor :computer_space_choice

  def initialize
    @computer_space_choice = 0
  end

  def computer_chooses_space
    computer_space_choice = rand(1..9)
    computer_space_choice
  end
end


class Tic_Tac_Toe
  attr_accessor :board, :spaces, :player, :computer, :player_choice, :computer_choice, :winning_spaces

  def initialize
    @board = Board.new
    @spaces = board.tic_tac_toe_spaces
    @player = Player.new
    @computer = Computer.new
    @player_choice = 0
    @computer_choice = 0
    @winning_spaces = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  end

  def player_turn
    begin
      player_choice = player.player_chooses_space
      if board.space_open_for_mark?(player_choice)
        board.mark_player_on_board(player_choice)
        board.draw_board
        break
      else
        puts "Please choose an open space."
      end
    end until board.space_open_for_mark?(player_choice) 
  end

  def computer_turn(board_spaces)
    position = empty_positions(board_spaces).sample
    board_spaces[position] = "O"
    board.draw_board
  end

  def any_winning_lines?(board_spaces)
    winning_spaces.each do |line|
      if board_spaces[line[0]] == "X" && board_spaces[line[1]] == "X" && board_spaces[line[2]] == "X"
        return "Player"
      elsif board_spaces[line[0]] == "O" && board_spaces[line[1]] == "O" && board_spaces[line[2]] == "O"
        return "Computer"
      end
    end
  end

  def winner_check(board_spaces)
    if any_winning_lines?(board_spaces) == "Player"
      "Player Wins!"
    elsif any_winning_lines?(board_spaces) == "Computer"
      "Computer Wins!"
    else
      nil
    end
  end

  def empty_positions(board_spaces)
    board_spaces.select { |keys, values| values == " "}.keys
  end

  def player_continues?
    begin
      puts "Would you like to play again? Y/N"
      player_continues_choice = gets.chomp.upcase
      if ["Y", "N"].include?(player_continues_choice) == false
        puts "Please type Y (Yes) or N (No)."
      end
    end until ["Y", "N"].include?(player_continues_choice)
    player_continues_choice
  end

  def run
    begin
      # coin_toss = CoinTossIntro.new.run
      board.clear_board_for_new_game(spaces)
      board.draw_board
      # if coin_toss == true
      #   puts "You won the toss!"
      #   player_turn
      # end
      begin
        player_turn        
        computer_turn(spaces)
      end until empty_positions(spaces).empty? || winner_check(spaces)
      if winner_check(spaces)
        puts winner_check (spaces)
      else
        puts "It's a Tie!"
      end
      game_continues = player_continues?
    end until game_continues == "N"
  end
end

new_game = Tic_Tac_Toe.new
new_game.run







