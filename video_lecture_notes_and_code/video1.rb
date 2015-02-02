##OOP in Ruby
# 1. classes and objects
# 2. classes contain behaviors
# 3. instance variables contain states
# 4. objects are instatiated from classes, and contain states and behaviors
# 5. class variables and class methods
# 6. compare with procedural

class Dog
  attr_accessor :name, :height, :weight

  @@count = 0

  def self.total_dogs
    "Total number of dogs: #{@@count}"
  end


  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
    @@count += 1
  end

  def speak
    "My name is #{name}"
  end

  def info
    "#{name} is #{height} feet tall and weighs #{weight} pounds."
  end

  def update_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
end

teddy = Dog.new('teddy', 3, 95)
fido = Dog.new('fido', 1, 35)
duchess = Dog.new('duchess', 0.5, 30)

puts teddy.info
teddy.update_info('Roosevelt', 10, 2000)
puts teddy.speak

puts Dog.total_dogs

