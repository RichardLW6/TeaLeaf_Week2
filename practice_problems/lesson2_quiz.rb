#LESSON 2 QUIZ - My answers

#1.

#a = 1 is a local variable
#@a = 2 is a instance variable
#user = User.new is an object, an instance of the class User
#user.name is accessing the @name class variable in user by accessing the attr_accessor method :name, or it could also be accessing the def user instance method
#user.name = "Joe" is setting the instance variable "name" to "Joe"

#2.

#A class mixes in a module when there is an "include (Module)" within the class. All methods within the module are now able to be used by that class

#3.

#Class variables, like @@variable, are only attached the the class (not the instance of that class).  They cannot be changed or called by an instance of that class.

#Instance variables are assigned to states of the instances of the class.  They can be called on instances of a class, but not directly on the class object itself.

#4.

#attr_accessor acts as both the "getter" and the "setter" method for instance variables wrapped up into one.  A symbol is passed into it, the symbol having the same name as the instance variable, and then the user is able to both retrieve the value ("get") of that variable from outside of the object as well as reassign or change the value ("set") of that variable from outside the object.

#5.

#This is a class method being passed on the class Dog.

#6.

#Mixing in modules does not change any state of that module.  You can alter how the module works within the class that it is mixed into by overriding methods or adding to them with "super", but you aren't changing states.  Subclassing the module is actually creating a new instance of that module, complete with different states.

#7.

#It would look like the following:

# class User
#   def initialize(name)
#     @name = name
# end

#8.

#Yes, you can. You can include them in your other methods.

#9.

#Use the require 'pry', then do binding.pry to find out the values of certain variables and results of methods.  

