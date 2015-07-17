
#Tic Tac Toe Board
class Board

  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @data = {}
  end

  def create_clear_board
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end

  def show_board
    system 'clear'
    puts "\n\n     |     |     "
    puts "  #{@data[1]}  |  #{@data[2]}  |  #{@data[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@data[4]}  |  #{@data[5]}  |  #{@data[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@data[7]}  |  #{@data[8]}  |  #{@data[9]}  "
    puts "     |     |     \n\n"    
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

  def mark_space(position, marker)
    @data[position] = marker
  end

  def winning_lines?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]] == marker && @data[line[1]] == marker && @data[line[2]] == marker 
    end
      false
  end

end

#Square within the board
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
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  attr_accessor :current_player, :board

  def initialize
    @board = Board.new
    @human = Player.new("Richard", "X")
    @computer = Player.new("Darth", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Please choose a space (1-9)"
        choice = gets.chomp.to_i
      end until @board.empty_positions.include?(choice)
    else
      choice = @board.empty_positions.sample
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

  def run
    begin
      @board.create_clear_board
      @board.show_board
      loop do
        current_player_marks_square
        @board.show_board
        if winner_check == true
          puts "The winner is #{@current_player.name}!"
          break
        elsif @board.no_spaces_available?
          puts "It's a draw!"
          break
        else
          next_turn
        end
      end 
    end until play_another_game? == 'N'
  end

end


Game.new.run


