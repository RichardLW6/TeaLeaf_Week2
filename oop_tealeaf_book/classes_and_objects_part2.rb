#### CLASSES AND OBJECTS - PART II

# class MyCar

#   attr_accessor :year, :model, :color

#   def initialize(y, m, c)
#     self.year = y
#     self.model = m
#     self.color = c
#     @speed = 0
#   end

#   def self.gas_mileage(gallons, miles)
#     puts "Your car currently gets #{miles / gallons} miles per gallon."
#   end



#   def speed_up(number)
#     @speed += number
#     puts "You sped up the car by #{number} mph."
#   end

#   def brake(number)
#     @speed -= number
#     puts "You hit the brakes, slowing the car down by #{number} mph."
#   end

#   def shut_off
#     @speed = 0
#     puts "You shut the car down."
#   end

#   def speed
#     puts "You are currently going at a speed of #{@speed} mph."
#   end

#   def spray_paint
#     puts "What color would you like to spray paint the car?"
#     paint_answer = gets.chomp
#     self.color = paint_answer
#     puts "Awesome. You just spray-painted your car #{color}."
#   end

#   def to_s
#     puts "You are currently driving a #{self.year} #{self.model} with the color #{self.color}"
#   end

# end


# MyCar.gas_mileage(20, 450)

# frog_reno = MyCar.new('1997', 'Honda', 'Green')

# frog_reno.to_s


class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name




