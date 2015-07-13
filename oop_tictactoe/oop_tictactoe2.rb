#OOP Tic-Tac-Toe - 2nd Try

class Board
  attr_accessor :board_spaces

  #Puts current board out with all filled or unfilled spaces
  def show_board
    puts " " + board_spaces[1] + " | " + board_spaces[2] + " | " + board_spaces[3] + " "
    puts "-----------"
    puts " " + board_spaces[4] + " | " + board_spaces[5] + " | " + board_spaces[6] + " "
    puts "-----------"
    puts " " + board_spaces[7] + " | " + board_spaces[8] + " | " + board_spaces[9] + " "
  end

  #Clears the board for a new game
  def clear_board
    @board_spaces = ((1..9).to_a).product([" "]).to_h
  end
end

class Player
  #Player guesses the coin toss result
  def intro_coin_guess
    begin
    puts "Time to flip the coin. Do you guess Heads (H) or Tails (T)?"
    coin_guess = gets.chomp.upcase
    end until ["T","H"].include?(coin_guess)
    coin_guess == "T" ? "Tails" : "Heads"
  end
end

class TicTacToe

  attr_accessor :game_board, :human_player, :player_turn_number, :active_spaces

  WINNING_SPACES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @game_board = Board.new
    @human_player = Player.new
    @player_turn_number = 0
    @active_spaces = @game_board.board_spaces
  end

  #Coin is tossed
  def toss_coin
    ["Heads","Tails"].sample
  end

  #Coin toss action to see which player goes first
  def coin_toss_intro
    self.player_turn_number = 0
    coin_toss_result = toss_coin
    human_player_coin_guess = human_player.intro_coin_guess
    human_player_coin_guess == coin_toss_result ? who_goes_first = "Player" : who_goes_first = "Computer"
    self.player_turn_number = 1 if who_goes_first == "Player"
    puts "The result of the toss was #{coin_toss_result}, and you guessed #{human_player_coin_guess}."
    puts (who_goes_first == "Player" ? "The Player goes first!" : "The Computer goes first!")
  end

  #Human player chooses a space
  def player_turn
    begin
    puts "Please choose a space (1 - 9)"
    player_move = gets.chomp.to_i
    end until player_move.class == Fixnum && ((1..9).to_a).include?(player_move) && @active_spaces[player_move] == " "
    self.active_spaces[player_move] = "X"
    puts "You chose space #{player_move}!"
    game_board.show_board
  end

  #Computer player chooses a space
  def computer_turn
    begin
    computer_move = (1..9).to_a.sample
    end until active_spaces[computer_move] == " "
    puts "\nThe Computer makes a move, choosing space #{computer_move}...\n\n"    
    self.active_spaces[computer_move] = "O"
    game_board.show_board
  end

  #Checks the spaces to see if any Player has won
  def check_for_winner
    winning_spaces_filled = WINNING_SPACES.map {|space| @active_spaces[space[0]] + @active_spaces[space[1]] + @active_spaces[space[2]]}
    if winning_spaces_filled.include?("OOO")
      "Computer"
    elsif winning_spaces_filled.include?("XXX")
      "Player"
    end
  end

  #Checks to see if board has openings or is full
  def check_for_open_board
    active_spaces.values.include?(" ")
  end

  #Announces the Winner or a Tie
  def announce_the_result
    if check_for_winner == "Computer"
      "The Computer wins!\n"
    elsif check_for_winner == "Player"
      "The Player wins!\n"
    elsif check_for_open_board == false
      "It's a tie!"
    end
  end

  #Asks player if he/she would like to Play Again
  def start_new_game?
    begin
    puts "Would you like to play again? (Y/N)"
    continue_answer = gets.chomp.upcase
    end until ["Y","N"].include?(continue_answer)
    continue_answer == "Y"
  end

  #Plays the game
  def run
    begin
      self.active_spaces = game_board.clear_board
      coin_toss_intro
      game_board.show_board
      begin
        if player_turn_number%2 == 1 
          player_turn
          self.player_turn_number += 1
        else
          computer_turn
          self.player_turn_number += 1
        end 
      end until check_for_winner == "Computer" || check_for_winner == "Player" || check_for_open_board == false
      puts announce_the_result
    end until start_new_game? == false
  end
end

TicTacToe.new.run