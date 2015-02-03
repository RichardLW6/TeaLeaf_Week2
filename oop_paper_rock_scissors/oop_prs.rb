# 1. Player chooses P/R/S
# 2. Computer chooses P/R/S
# 3. Choices are compared
# 4. Winner, or tie, is decided, and choices and results are shown

class Player
  attr_accessor :player_choice

  def initialize
    begin
      puts "Choose one: (P/R/S)"
      @player_choice = gets.chomp.upcase
    end until ['P', 'R', 'S'].include?(player_choice)
    if player_choice == 'R'
      player_choice = 'Rock'
    elsif player_choice == 'S'
      player_choice = 'Scissors'
    else
      player_choice = 'Paper'
    end
  end
end

class Computer
  attr_accessor :computer_choice

  def initialize
    @computer_choice = ['Paper', 'Rock', 'Scissors'].sample
  end
end

class PaperRockScissors
  attr_accessor :player, :computer 

  def initialize
    @player = Player.new.player_choice
    @computer = Computer.new.computer_choice
  end

  def continue?
    begin
      puts "Play Again? (Y/N)"
      continue_answer = gets.chomp.upcase
    end until ['Y', 'N'].include?(continue_answer)
    if continue_answer == 'Y'
      PaperRockScissors.new.run
    end
  end

  def run
    puts "You picked #{player} and computer picked #{computer}."
    if player == computer
       puts "It's a TIE!"
    elsif (player == 'Rock' && computer == 'Paper') ||
      (player == 'Paper' && computer == 'Scissors') ||
      (player == 'Scissors' && computer == 'Rock')
      puts "Computer won!"
    else
      puts "You won!"
    end
    continue?
  end
end

PaperRockScissors.new.run


