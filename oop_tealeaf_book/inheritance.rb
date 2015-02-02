#### INHERITANCE

# module TruckCarrying
#   def carry_capacity
#     puts "How much does your truck weight in lb.?"
#     weight_answer = gets.chomp.to_i
#     puts "Your truck can carry " + (weight_answer/5).to_s + " pounds of junk."
#   end
# end


# class Vehicle


#   attr_accessor :year, :model, :color

#   @@number_of_objects = 0

#   def initialize(year, model, color)
#     @year = year
#     @model = model
#     @color = color
#     @speed = 0
#     @@number_of_objects += 1
#   end


#   def find_age
#     puts "Your #{self.model} is currently #{age} years old."

#   end

#   def self.number_of_vehicles
#     puts "This program has created #{@@number_of_objects} vehicles."
#   end

#   def self.gas_mileage(gallons, miles)
#     puts "You currently gets #{miles / gallons} miles per gallon."
#   end

#   def speed_up(number)
#     @speed += number
#     puts "You sped up by #{number} mph."
#   end

#   def brake(number)
#     @speed -= number
#     puts "You hit the brakes, slowing down by #{number} mph."
#   end

#   def shut_off
#     @speed = 0
#     puts "You shut off the vehicle."
#   end

#   def speed
#     puts "You are currently going at a speed of #{@speed} mph."
#   end

#   def to_s
#     puts "You are currently driving a #{self.year} #{self.model} with the color #{self.color}"
#   end

#   private


#   def age
#     Time.now.year - self.year
#   end

# end



# class MyCar < Vehicle

#   NUMBER_OF_DOORS = 4

#   def spray_paint
#     puts "What color would you like to spray paint the car?"
#     paint_answer = gets.chomp
#     self.color = paint_answer
#     puts "Awesome. You just spray-painted your car #{color}."
#   end

# end


# class MyTruck < Vehicle


#   NUMBER_OF_DOORS = 4

#   def spray_paint
#     puts "What color would you like to spray paint the truck?"
#     paint_answer = gets.chomp
#     self.color = paint_answer
#     puts "Awesome. You just spray-painted your truck #{color}."
#   end

#   include TruckCarrying

# end


# honda = MyCar.new(1997, 'Honda', 'Green')

# F100 = MyTruck.new(1992, 'F100', 'Red')



class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end

end


joe = Student.new("Joe", 97)

richard = Student.new("Richard", 80)

puts "Well done!" if joe.better_grade_than?(richard)








