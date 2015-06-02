#OOP Paper, Rock, Scissors - Second Version (May/June 2015)


class Player

  attr_accessor :player_choice

  def initialize
    @player_choice = ""
  end

  def player_chooses
    begin
      puts "Please choose Paper (P), Rock (R), or Scissors (S)..."
      self.player_choice = gets.chomp.upcase
    end until ['P', 'R', 'S'].include?(self.player_choice) == true
    case self.player_choice
    when 'P'
      self.player_choice = 'Paper'
    when 'R'
      self.player_choice = 'Rock'
    when 'S'
      self.player_choice = 'Scissors'
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

  attr_accessor :user, :opponent, :outcome, :winner, :continue_option

  def initialize
    puts "Welcome to Paper, Rocks, and Scissors!\n"
    @user = ""    
    @opponent = ""
    @outcome = ""
    @winner = true
    @continue_option
  end

  def choose_hands
    self.user = Player.new.player_chooses
    self.opponent = Computer.new.computer_choice
  end

  def player_wins?
    if (self.user == 'Rock' && self.opponent == 'Scissors') || 
      (self.user == 'Paper' && self.opponent == 'Rock') || 
      (self.user == 'Scissors' && self.opponent == 'Paper')
      self.winner = true
    elsif user == opponent
      self.winner = 'Tie'
    else
      self.winner = false
    end
  end

  def make_outcome
    self.outcome = "You chose #{self.user} and the computer chose #{self.opponent}\n"
  end

  def show_winner
    if winner == true
      puts outcome
      puts "Player wins!"
    elsif winner == false
      puts outcome
      puts "Computer wins!"
    else
      puts outcome
      puts "It's a Tie!"
    end
  end

  def play_again?
    begin
    puts "Would you like to play again? (Y/N)"
    self.continue_option = gets.chomp.upcase
    end until ['Y', 'N'].include?(continue_option)
  end

  def run
    begin
    choose_hands
    player_wins?
    make_outcome
    puts winner
    show_winner
    play_again?
    end until continue_option == 'N'
  end
end

PaperRockScissors.new.run

