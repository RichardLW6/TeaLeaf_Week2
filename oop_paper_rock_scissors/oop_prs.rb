# PAPER/ROCK/SCISSORS - V1

# Player Chooses 
class Player_Hand
  attr_reader :player_choice

  def initialize
    begin
      puts "Choose one: (P/R/S)"
      @player_choice = gets.chomp.upcase
    end until ['P', 'R', 'S'].include?(player_choice)
    if @player_choice == 'R'
      @player_choice = 'Rock'
    elsif player_choice == 'S'
      @player_choice = 'Scissors'
    else
      @player_choice = 'Paper'
    end
  end
end

# Computer Chooses
class Computer_Hand
  attr_reader :computer_choice

  def initialize
    @computer_choice = ['Paper', 'Rock', 'Scissors'].sample
  end
end

# Paper/Rock/Scissors Game
class PaperRockScissors
  attr_reader :player, :computer 

  @@player_score = 0
  @@computer_score = 0

  def initialize
    @player = Player_Hand.new.player_choice
    @computer = Computer_Hand.new.computer_choice
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

  def choice_announce
    puts "You picked #{player} and the computer picked #{computer}."
  end

  def comparison_of_choices
    if player == computer
       puts "It's a TIE!"
    elsif (player == 'Rock' && computer == 'Paper') ||
      (player == 'Paper' && computer == 'Scissors') ||
      (player == 'Scissors' && computer == 'Rock')
      puts "Computer won!"
      @@computer_score += 1
    else
      puts "You won!"
      @@player_score += 1
    end
  end

  def say_score
    puts "Player: #{@@player_score}"
    puts "Computer: #{@@computer_score}"
  end

  def run
    choice_announce
    comparison_of_choices
    say_score
    continue?
  end
end

PaperRockScissors.new.run


