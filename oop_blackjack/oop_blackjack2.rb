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
    "#{face_value} of #{suit}"
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

class Player
  include Hand

  attr_accessor :name, :cards, :money

  def initialize
    @name = name
    @cards = []
    @money = Money.new
  end

  def get_name
    begin
      puts "What is your name?"
      answer = gets.chomp
    end until answer.empty? == false
    self.name = answer
  end

  def starting_money_amount
    answer = 0
    begin
      puts "How much money would you like to withdraw from the ATM?"
      answer = gets.chomp.to_i
    end until answer > 0
    money.amount = answer
  end

  def player_loses_money(amount)
    money.lose(amount)
  end

  def player_gets_money(amount)
    money.add_to(amount)
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

  def is_thinking
    delay_time = [1, 2, 3].sample
    puts "The Dealer is thinking..."
    sleep(delay_time)
  end
end

class Money
  attr_accessor :amount

  def initialize
    @amount = amount
  end

  def broke
    amount <= 0
  end

  def add_to(winnings)
    self.amount += winnings
  end

  def lose(bet)
    self.amount -= bet
  end

  def to_s
    "#{amount} dollars."
  end

  def enough_money?(request)
    amount >= request
  end
end

class Blackjack

  BLACKJACK_AMOUNT = 21
  DEALER_MIN_HIT_AMOUNT = 17

  attr_accessor :deck, :player, :dealer, :current_bet

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @current_bet = 0
  end

  def reset
    self.deck = Deck.new
    self.player.cards = []
    self.dealer.cards = []
    self.current_bet = 0
  end

  def deal_player_card(player, number_of_cards)
    number_of_cards.times do 
      player.cards << deck.deal_card
    end
  end

  def hits(player)
    deal_player_card(player, 1)
  end

  def player_intro
    system 'clear'
    puts "Welcome to Blackjack!"
    begin
      answer = ''
      player.get_name
      player.starting_money_amount
      player_greeting
      begin
        puts "Does this sound correct? (Y/N)"
        answer = gets.chomp.upcase
      end until ['Y','N'].include?(answer)
    end until answer == 'Y'
  end

  def total_player_money
    player.money
  end

  def player_greeting
    puts "Great! Nice to meet you, #{player.name}. I can't wait to steal your #{total_player_money}"
  end

  def initial_deal_to_player_and_dealer
    system 'clear'
    deal_player_card(player, 2)
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
    if player.total > dealer.total && player.safe? || player.blackjack? || dealer.busted?
      "Player"
    elsif dealer.total > player.total && dealer.safe? || player.busted?
      "Dealer"
    else
      "Push"
    end
  end

  def player_turn
    begin
      system 'clear'
      dealer_shows_one_card
      player.show_hand
      if player.blackjack?
        puts "Congratulations, you just got Blackjack!"
        break
      elsif player.busted?
        puts "You just busted and lost!"
        break
      end 
    hits = stay_or_hit?
    if hits == 'Y'
      hits(player)
    end
    end until hits == 'N'
    player.cards
  end

  def player_bets
    puts "You have #{total_player_money}"
    begin
      puts "How much money would you like to bet?"
      answer = gets.chomp.to_i
    end until total_player_money.enough_money?(answer)
    self.current_bet = answer
  end

  def do_dealer_turn?
    player.safe? && !player.blackjack?
  end

  def dealer_flips
    puts "The dealer flips his other card and shows:"
    dealer.show_hand
  end

  def display_all_hands
    system 'clear'
    player.show_hand
    dealer.show_hand
  end

  def dealer_decision_time
    begin
      display_all_hands
      if dealer.good_score? || who_has_winning_hand? == "Dealer"
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

  def dealer_turn
    if do_dealer_turn?
      system 'clear'
      dealer_flips
      dealer_decision_time
    end
  end

  def announce_winner
    case who_has_winning_hand?
    when "Player"
      puts "#{self.player.name} wins!"
      player_wins_bet
    when "Dealer"
      puts "Dealer wins!"
      player_loses_bet
    when "Push"
      puts "PUSH - It's a draw!"
    end
  end

  def player_wins_bet
    self.current_bet *= 2
    player.player_gets_money(current_bet)
    puts "Congratulations, you win #{current_bet} dollars!"
  end

  def player_loses_bet
    player.player_loses_money(current_bet)
    puts "Not cool. You just lost #{current_bet} dollars!"
  end

  def give_player_total_money
    puts "You now have #{total_player_money}."
  end

  def play_again?
    begin
      puts "Would you like to play again?"
      answer = gets.chomp.upcase
    end until ['Y','N'].include?(answer)
    answer
  end

  def broke_check
    total_player_money.amount <= 0
  end

  def player_is_broke
    puts puts "Too bad you're broke! Get out of here!"  
  end

  def run
    player_intro
    begin
      initial_deal_to_player_and_dealer
      player_bets
      dealer_shows_one_card
      player_turn
      dealer_turn
      announce_winner
      give_player_total_money
      reset
      if broke_check == true
        player_is_broke
        break 
      end
    end until play_again? == 'N'
  end
end

Blackjack.new.run
