# 1a

x = 4

loop do 
  x = 'hey there'
  break
end

puts x

# 1b

def no_mutate(arr)
  arr.uniq #does not mutate the caller
end

my_arr = [1, 2, 2, 3]
no_mutate(my_arr)

puts my_arr

# 1c

def yes_mutate(arr)
  arr.uniq!
end

my_arr = [1, 2, 2, 3]
yes_mutate(my_arr)

puts my_arr

# 2

my_arr2 = [1, 2, 3, 4, 5]

my_arr2.each do |a| 
  b = 1
end

#puts b

# variablescope.rb:42:in `<main>': undefined local variable or method `b' for main:Object (NameError)

my_arr2 = [1, 2, 3, 4, 5]

my_arr2.each do |a| 
  my_arr2b = [1, 3, 5, 7, 9]
  my_arr2b.each do |b|
    c = 3
  end
  #puts c
end

#variablescope.rb:53:in `block in <main>': undefined local variable or method `c' for main:Object (NameError)
#  from variablescope.rb:48:in `each'
#  from variablescope.rb:48:in `<main>'

x = “hi”

def my_method
  puts x
end

my_method

# variablescope.rb:60:in `<main>': undefined local variable or method `“hi”' for main:Object (NameError)

