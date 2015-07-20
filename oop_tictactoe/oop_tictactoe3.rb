#Tic Tac Toe OOO - 3rd Try

class Scoreboard
  attr_accessor :human_score, :computer_score

  def initialize(human_name, computer_name)
    @human_name = human_name
    @computer_name = computer_name
    @human_score = 0
    @computer_score = 0
  end

  def show_scoreboard
    puts "                                       "
    puts "                                       "
    puts "   -------------SCOREBOARD-------------"
    puts "                                       "
    puts "      #{@computer_name}: #{@computer_score}            #{@human_name}: #{@human_score}"
    puts "                                       "
    puts "                                       "
    puts "   ------------------------------------"  
  end
end

class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @data = {}
  end

  def create_clear_board
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end

  def show_board
    puts "\n\n        |     |     "
    puts "     #{@data[1]}  |  #{@data[2]}  |  #{@data[3]}  "
    puts "        |     |     "
    puts "   -----+-----+-----"
    puts "        |     |     "
    puts "     #{@data[4]}  |  #{@data[5]}  |  #{@data[6]}  "
    puts "        |     |     "
    puts "   -----+-----+-----"
    puts "        |     |     "
    puts "     #{@data[7]}  |  #{@data[8]}  |  #{@data[9]}  "
    puts "        |     |     \n\n"    
  end

  def empty_spaces
    @data.select {|_, position| position.empty?}.values
  end

  def empty_positions
    @data.select {|_, position| position.empty?}.keys
  end

  def no_spaces_available?
    empty_spaces.length == 0
  end

  def center_position_open?
    empty_positions.include?(5)
  end

  def mark_space(position, marker)
    @data[position] = marker
  end

  def winning_lines?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]] == marker && @data[line[1]] == marker && @data[line[2]] == marker 
    end
      false
  end

  def player_almost_winning_lines(marker)
    WINNING_LINES.select do |line|
      line_check = [@data[line[0]], @data[line[1]], @data[line[2]]]
      (line_check.join).split("").sort == [" ", marker, marker]
    end
  end

  def player_almost_winning_position(marker)
    if player_almost_winning_lines(marker) != []
      (player_almost_winning_lines(marker)[0]).select do |position|
        empty_positions.include?(position)
      end
    end
  end

  def player_close_to_winning?(marker)
    player_almost_winning_lines(marker).length > 0
  end
end

class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def empty?
    @value == ' '
  end

  def to_s
    @value
  end
end

class Player
  attr_reader :name, :marker, :skill

  def initialize(marker)
    @name = ""
    @marker = marker
    @skill = 0
    name_player
  end

  def name_player_as_human
    begin 
      system 'clear'
      puts "\nWhat is your name?"
      answer = gets.chomp
    end until answer.length > 0
    @name = answer    
  end

  def name_player_as_computer
    begin
      puts "Would you like to play C3PO (easy), Wall-E (medium), or Hal 2000 (hard)? (Type C, W, or H)"
      answer = gets.chomp.upcase
    end until ['C','W','H'].include?(answer)
    case answer
    when 'C'
      @name = 'C3PO'
    when 'W'
      @name = 'Wall-E'
      @skill = 1
    when 'H'
      @name = 'Hal 2000'
      @skill = 2
    end
  end

  def name_player
    if marker == "X"
      name_player_as_human
    else
      name_player_as_computer
    end
  end
end

class Game
  attr_accessor :current_player, :board

  def initialize
    @board = Board.new
    @human = Player.new("X")
    @computer = Player.new("O")
    @scoreboard = Scoreboard.new(@human.name, @computer.name)
    @current_player = @human 
  end

  def computer_choice_to_block_player_win
      @board.player_almost_winning_position("X")[0]
  end

  def computer_marks_winning_space
      @board.player_almost_winning_position("O")[0]
  end

  def computer_marks_center_position
    if @board.center_position_open?
      5
    end
  end

  def easy_computer_space_choice
    @board.empty_positions.sample
  end

  def medium_computer_space_choice
    if @board.player_close_to_winning?("O")
      computer_marks_winning_space
    elsif @board.player_close_to_winning?("X")
      computer_choice_to_block_player_win
    else
      easy_computer_space_choice
    end
  end

  def hard_computer_space_choice
    if board.center_position_open?
      5
    else
      medium_computer_space_choice
    end
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Please choose a space (1-9)"
        choice = gets.chomp.to_i
      end until @board.empty_positions.include?(choice)
    elsif @current_player == @computer
      case @current_player.skill
      when 0
        choice = easy_computer_space_choice
      when 1
        choice = medium_computer_space_choice
      when 2
        choice = hard_computer_space_choice
      end
    end
    @board.mark_space(choice, @current_player.marker)
  end

  def next_turn
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def winner_check
    @board.winning_lines?(@current_player.marker)
  end

  def play_another_game?
    begin
      puts "Would you like to play again? (Y/N)"
      answer = gets.chomp.upcase
    end until ['Y','N'].include?(answer)
    answer
  end

  def update_scoreboard
    if @current_player == @human
      @scoreboard.human_score += 1
    else
      @scoreboard.computer_score += 1
    end
  end

  def show_score_and_board
    system 'clear'
    @scoreboard.show_scoreboard
    @board.show_board
  end

  def run
    begin
      @current_player = [@human, @computer].sample
      @board.create_clear_board
      show_score_and_board
      loop do
        current_player_marks_square
        show_score_and_board
        if winner_check == true
          update_scoreboard
          show_score_and_board
          puts "#{@current_player.name} is the winner!\n\n"
          break
        elsif @board.no_spaces_available?
          puts "It's a draw!\n\n"
          break
        else
          next_turn
        end
      end 
    end until play_another_game? == 'N'
  end
end

Game.new.run