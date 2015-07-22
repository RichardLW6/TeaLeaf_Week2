#OOP Blackjack

class Deck
  attr_accessor :cards

  CARD_RANKS = ["2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"]
  CARD_SUITS = ["Hearts","Clubs","Spades","Diamonds"]

  def initialize
    @cards = []
    new_deck
    shuffle_deck!
  end

  def new_deck
    card_types = CARD_RANKS.product(CARD_SUITS)
    card_types.each {|card| @cards << Card.new(card[0],card[1])}    
  end


  def deal_card
    cards.pop
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def to_s
    cards.each {|card| puts card} 
  end

  def size
    cards.size
  end
end


class Card
  attr_accessor :face_value, :suit

  def initialize(fv, s)
    @face_value = fv
    @suit = s
  end

  def nice_looking_card
    "#{@face_value} of #{@suit}"
  end

  def to_s
    nice_looking_card
  end
end


module Hand
  def show_hand
    puts "----#{name}'s Hand----"
    cards.each do |card|
      puts "===> #{card}"
    end

    puts "TOTAL ===> #{total}"
  end

  def total
    face_values = cards.map {|card| card.face_value}

    total = 0
    face_values.each do |value|
      if value == "Ace"
        total += 11
      else
        value.to_i == 0 ? total += 10 : total += value.to_i
      end
    end

    face_values.select {|value| value == "Ace"}.count.times do 
      break if total <= 21
      total -= 10
    end

    total
  end

  def busted?
    total > 21
  end

  def safe?
    total <= 21
  end 

  def blackjack?
    total == 21 && cards.length == 2
  end
end


class Human
  include Hand

  attr_accessor :name, :cards 

  def initialize(name)
    @name = name
    @cards = []
  end

end


class Dealer
  include Hand

  attr_accessor :cards
  attr_reader :name

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def good_score?
    total >= 17
  end

  def weak_score?
    total < 17
  end

end


class Game
  attr_accessor :deck, :human, :dealer

  def initialize
    reset
  end

  def reset
    @deck = Deck.new
    @human = Human.new("Richard")
    @dealer = Dealer.new
  end


  def deal_player_card(player, number_of_cards)
    number_of_cards.times do 
      player.cards << deck.deal_card
    end
  end


  def hits(player)
    deal_player_card(player, 1)
  end


  def initial_deal_to_players
    deal_player_card(human, 2)
    deal_player_card(dealer, 2)
  end


  def dealer_shows_one_card
    puts "The dealer is showing:"
    puts dealer.cards.first
  end


  def stay_or_hit?
    begin
      puts "Would you like to Hit? (Y/N)"
      answer = gets.chomp.upcase
    end until ['Y','N'].include?(answer)
    answer
  end


  def who_has_winning_hand?
    if human.total > dealer.total && human.safe? || human.blackjack? || dealer.busted?
      "Human"
    elsif dealer.total > human.total && dealer.safe? || human.busted?
      "Dealer"
    else
      "Push"
    end
  end


  def human_turn
    begin
      human.show_hand
      if human.blackjack?
        puts "Congratulations, you just got Blackjack!"
        break
      elsif @human.busted?
        puts "You just busted and lost!"
        break
      end 
    hits = stay_or_hit?
    if hits == 'Y'
      hits(human)
    end
    end until hits == 'N'
    human.cards
  end


  def do_dealer_turn?
    human.safe? && !human.blackjack?
  end


  def dealer_flips
    puts "The dealer flips his other card and shows:"
    dealer.show_hand
  end


  def dealer_turn
    while dealer.weak_score? == true
      puts "The dealer hits..."
      hits(dealer)
      dealer.show_hand
      if dealer.busted?
        puts "The dealer busted!"
      elsif dealer.blackjack?
        puts "The dealer gets a Blackjack!"
      end
    end
  end

  def announce_winner
    case who_has_winning_hand?
    when "Human"
      puts "You win!"
    when "Dealer"
      puts "Dealer wins!"
    when "Push"
      puts "PUSH - It's a draw!"
    end
  end

  def play_again?
    begin
      puts "Would you like to play again?"
      answer = gets.chomp.upcase
    end until ['Y','N'].include?(answer)
    answer
  end


  def run
    begin
      initial_deal_to_players
      dealer_shows_one_card
      human_turn
      if do_dealer_turn?
        dealer_flips
        dealer_turn
      end
      announce_winner
      reset
    end until play_again? == 'N'
  end

end

Game.new.run

