puts "Type your email address:"

email = gets.chomp

pattern = /\w+@\w+.\w{2,}?+*.\w{2}$/i

if email.match?(pattern)
  puts "This is a valid email!"
else
  puts "Not an valid email! Try again"
end