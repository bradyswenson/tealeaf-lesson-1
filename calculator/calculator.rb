require 'pry'

def say(msg)
  puts "=> #{msg}"
end

begin

say "Enter the first number."
num1 = gets.chomp 

say "Enter the second number."
num2 = gets.chomp

say "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp

if operator == '1'
  result = num1.to_i + num2.to_i
elsif operator == '2'
  result = num1.to_i - num2.to_i
elsif operator == '3'
  result = num1.to_i * num2.to_i
else
  if num2.to_i !=  0
    result = num1.to_f / num2.to_f
  else
    result = "cannot divide by zero."
  end
end

puts "Result is #{result}"

say "Do you want to make another calculation? (Y/N)"
answer = gets.chomp

end while answer == 'Y'


