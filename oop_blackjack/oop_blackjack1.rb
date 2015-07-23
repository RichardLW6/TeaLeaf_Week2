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
    puts "----------------------"

    puts "TOTAL ===> #{total}\n\n"
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
      break if total <= Blackjack::BLACKJACK_AMOUNT
      total -= 10
    end

    total
  end

  def busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end

  def safe?
    total <= Blackjack::BLACKJACK_AMOUNT
  end 

  def blackjack?
    total == Blackjack::BLACKJACK_AMOUNT && cards.length == 2
  end
end

class Human
  include Hand

  attr_accessor :name, :cards 

  def initialize
    @name = name
    @cards = []
    get_name
  end

  def get_name
    system 'clear'
    begin
      puts "Welcome to Blackjack! What is your name?"
      answer = gets.chomp
    end until answer.empty? == false
    self.name = answer
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
    total >= Blackjack::DEALER_MIN_HIT_AMOUNT
  end

  def weak_score?
    total < Blackjack::DEALER_MIN_HIT_AMOUNT
  end

  def is_thinking
    delay_time = [1, 2, 3].sample
    puts "The Dealer is thinking..."
    sleep(delay_time)
  end
end

class Blackjack

  BLACKJACK_AMOUNT = 21
  DEALER_MIN_HIT_AMOUNT = 17

  attr_accessor :deck, :human, :dealer

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end

  def reset
    deck = Deck.new
    human.cards = []
    dealer.cards = []
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
    system 'clear'
    deal_player_card(human, 2)
    deal_player_card(dealer, 2)
  end

  def dealer_shows_one_card
    puts "-----DEALER SHOWING-----\n\n"
    puts "===> #{dealer.cards.first}\n\n"
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
      system 'clear'
      dealer_shows_one_card
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

  def display_all_hands
    system 'clear'
    human.show_hand
    dealer.show_hand
  end

  def dealer_turn
    begin
      display_all_hands
      if dealer.good_score?
        break
      end
      dealer.is_thinking
      hits(dealer)
      display_all_hands
      puts "The dealer hits...and draws a #{dealer.cards[-1]}."
      sleep(1)
      if dealer.busted?
        puts "The dealer busted!"
      elsif dealer.blackjack?
        puts "The dealer gets a Blackjack!"
      end 
    end until dealer.good_score?
  end

  def announce_winner
    case who_has_winning_hand?
    when "Human"
      puts "#{self.human.name} wins!"
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
        system 'clear'
        dealer_flips
        dealer_turn
      end
      announce_winner
      reset
    end until play_again? == 'N'
  end
end

Blackjack.new.run