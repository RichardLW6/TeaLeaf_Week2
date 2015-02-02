#### CLASSES AND OBJECTS - PART I

# class GoodDog
#   attr_accessor :name, :height, :weight


#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end
 

  # def initialize(name)
  #   @name = name
  # end

  # def get_name
  #   @name
  # end

  # def set_name=(n)
  #   @name = n
  # end

#   def speak
#     "#{name} says arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{self.name} weighs #{self.weight} and is #{self.height} tall."
#   end

# end

# sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
# puts sparky.speak
# puts sparky.info
# sparky.change_info("Spartacus", "24 inches", "45 lbs")
# puts sparky.info


### EXERCISES

class MyCar

  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @speed = 0
  end

  def speed_up(number)
    @speed += number
    puts "You sped up the car by #{number} mph."
  end

  def brake(number)
    @speed -= number
    puts "You hit the brakes, slowing the car down by #{number} mph."
  end


  def shut_off
    @speed = 0
    puts "You shut the car down."
  end

  def speed
    puts "You are currently going at a speed of #{@speed} mph."
  end

  def spray_paint
    puts "What color would you like to spray paint the car?"
    paint_answer = gets.chomp
    self.color = paint_answer
    puts "Awesome. You just spray-painted your car #{color}."
  end


end


honda = MyCar.new('1997', 'Green', 'Honda_Civic')
puts honda.year
puts honda.color
honda.speed_up(35)
honda.brake(15)
honda.speed
honda.shut_off
honda.color = "Red"
puts honda.color
honda.spray_paint

