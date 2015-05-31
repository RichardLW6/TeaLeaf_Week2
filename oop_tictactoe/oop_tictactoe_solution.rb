


class Board
  def initialize
    @data = {}
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end


  def draw
    puts "Drawing...board..."
    puts @data.inspect
  end

  def all_squares_marked?
    empty_squares.size == 0
  end



  def empty_squares
    @data.select { |_, square| if square.value == ' '}.values
  end

  def empty_positions
    @data.select { |_, square| !square.empty? }.keys
  end


  def mark_square(position, marker)
    @data[position].mark(marker)
end


class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end  

  def mark(marker)
    @value = marker
  end

  def occupied?
    @value != ' '
  end

  def empty?
    @value == ' '
  end

end

class Player
  attr_reader :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end


class Game
  def initialize
    @board = Board.new
    @human = Player.new("Richard", "X")
    @computer = Player.new("R2D2", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player = @human
      begin
        puts "Choose a position (1-9):"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end


  def play
    @board.draw
    loop do
      current_player_marks_square


    end



  end


end


Game.new.play



# player
#   - name
#   - marker




# square
#   - occupied?
#   - mark(marker)