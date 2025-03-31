# encoding: utf-8
# comprehensive_ruby_overview.rb

# ==============================================================================
# ||                            Ruby Language Tour                            ||
# ==============================================================================
# This file aims to demonstrate a wide range of Ruby syntax and features.
# It's not exhaustive but covers major concepts.
# Execute this file with `ruby comprehensive_ruby_overview.rb` to see output.

puts "Starting the Ruby Language Tour..."
puts "==================================\n"

# ==============================================================================
# || 1. Basic Syntax & Comments                                               ||
# ==============================================================================

# This is a single-line comment.

=begin
This is a
multi-line
comment block.
=end

# Printing output
print "This prints without a newline." # Note the difference with puts
puts " This prints WITH a newline."    # puts = put string + newline

# Basic variable assignment (dynamic typing)
message = "Hello, Ruby!"
count = 10
price = 99.99
is_active = true
nothing = nil # Represents absence of value

puts "\n--- 1. Basic Syntax ---"
puts message
puts "Count: #{count}, Price: #{price}, Active: #{is_active}, Nothing: #{nothing.inspect}" # .inspect shows nil clearly

# String interpolation works only in double quotes
puts "Using single quotes: '#{message}'" # Interpolation doesn't happen here
puts "Using double quotes: \"#{message}\"" # Interpolation works here

# Constants (by convention, start with an uppercase letter)
PI = 3.14159
# PI = 3.14 # Ruby gives a warning but allows reassignment (discouraged)
puts "PI Constant: #{PI}"

# Symbols (lightweight, immutable string-like objects, often used as identifiers/keys)
status_symbol = :pending
puts "Status Symbol: #{status_symbol.inspect}, Class: #{status_symbol.class}"


# ==============================================================================
# || 2. Data Types & Basic Operations                                         ||
# ==============================================================================
puts "\n--- 2. Data Types ---"

# Numbers (Integer, Float)
integer_num = 42
float_num = 3.14
large_num = 1_000_000 # Underscores ignored, used for readability
puts "Numbers: #{integer_num}, #{float_num}, #{large_num}"
puts "Arithmetic: 5 + 3 = #{5 + 3}, 10 / 2 = #{10 / 2}, 10 / 3 = #{10 / 3} (Integer div), 10.0 / 3 = #{10.0 / 3} (Float div)"
puts "Modulo: 10 % 3 = #{10 % 3}"
puts "Exponent: 2 ** 3 = #{2**3}"

# Strings (Mutable)
first_name = "Ada"
last_name = 'Lovelace' # Single quotes are more literal
full_name = first_name + " " + last_name
puts "Full Name: #{full_name}"
puts "String methods: #{full_name.upcase}, Length: #{full_name.length}"
puts "Substring: #{full_name[0..2]}" # Inclusive range
puts "String modification: #{first_name.gsub!('a', 'o')}" # gsub! modifies in place
puts "First name is now: #{first_name}"

# Arrays (Ordered, integer-indexed collections of any objects)
my_array = [1, "two", 3.0, :four, [5, 6]]
puts "Array: #{my_array.inspect}"
puts "Accessing element: #{my_array[1]}" # "two"
puts "Nested element: #{my_array[4][0]}" # 5
my_array << "new element" # Appending using shovel operator
puts "Modified Array: #{my_array.inspect}"
puts "Array methods: Length=#{my_array.length}, First=#{my_array.first}, Last=#{my_array.last}"

# Word array shortcut
words = %w[this is a shortcut for string arrays]
puts "Word array: #{words.inspect}"

# Hashes (Key-value pairs, aka dictionaries or maps)
# Keys are often Symbols, but can be any object
my_hash = {
  name: "Charles Babbage", # Modern syntax (Ruby 1.9+) for symbol keys
  "occupation" => "Mathematician", # Older syntax, required for non-symbol keys
  year_born: 1791,
  123 => "Number key"
}
puts "Hash: #{my_hash.inspect}"
puts "Accessing value by key: #{my_hash[:name]}"
puts "Accessing via string key: #{my_hash["occupation"]}"
puts "Accessing via number key: #{my_hash[123]}"
my_hash[:invented] = "Difference Engine" # Adding a new key-value pair
puts "Modified Hash: #{my_hash.inspect}"
puts "Hash methods: Keys=#{my_hash.keys.inspect}, Values=#{my_hash.values.inspect}"

# Ranges (Represent a sequence)
inclusive_range = 1..5  # 1, 2, 3, 4, 5
exclusive_range = 1...5 # 1, 2, 3, 4
puts "Inclusive Range (1..5): #{inclusive_range.to_a.inspect}" # Convert to array to see elements
puts "Exclusive Range (1...5): #{exclusive_range.to_a.inspect}"
puts "Is 3 in range? #{(1..5).include?(3)}"


# ==============================================================================
# || 3. Control Flow                                                          ||
# ==============================================================================
puts "\n--- 3. Control Flow ---"

# if / elsif / else / end
temperature = 25
if temperature > 30
  puts "It's hot!"
elsif temperature > 20
  puts "It's nice."
else
  puts "It's cool or cold."
end

# Statement modifier (inline if)
puts "It's definitely warm." if temperature > 20

# unless (opposite of if)
is_raining = false
puts "Go outside!" unless is_raining

# Statement modifier (inline unless)
puts "Bring an umbrella just in case." unless !is_raining # A bit contrived example

# case statement (like switch)
grade = 'B'
case grade
when 'A'
  puts "Excellent!"
when 'B', 'C' # Multiple values
  puts "Good job."
when 'D'
  puts "Needs improvement."
else
  puts "Invalid grade."
end

# Case statement can also use conditions
score = 85
result = case score
         when 90..100 then "A"
         when 80..89 then "B"
         when 70..79 then "C"
         else "D or F"
         end
puts "Score #{score} gets grade: #{result}"

# Ternary operator
permission = (temperature > 22) ? "Granted" : "Denied"
puts "Permission based on temp: #{permission}"


# ==============================================================================
# || 4. Loops & Iterators                                                     ||
# ==============================================================================
puts "\n--- 4. Loops & Iterators ---"

# while loop
counter = 0
while counter < 3
  puts "While loop, counter: #{counter}"
  counter += 1
end

# until loop (opposite of while)
counter = 3
until counter == 0
  puts "Until loop, counter: #{counter}"
  counter -= 1
end

# loop do (infinite loop, needs break)
inf_counter = 0
loop do
  puts "Loop do, counter: #{inf_counter}"
  inf_counter += 1
  break if inf_counter >= 2 # Exit condition
end

# for loop (less common in modern Ruby, often uses iterators instead)
for i in 0..2 # Using a range
  puts "For loop (range), i: #{i}"
end

fruits = ["apple", "banana", "cherry"]
for fruit in fruits
  puts "For loop (array): #{fruit}"
end

# --- Iterators (The Ruby Way) ---
# These use blocks (code passed to methods)

# .each (most common iterator)
puts "Using .each:"
fruits.each do |fruit|
  puts "  - #{fruit.capitalize}"
end

# .each with index
puts "Using .each_with_index:"
fruits.each_with_index do |fruit, index|
  puts "  Index #{index}: #{fruit}"
end

# Hash iteration
puts "Using .each on hash:"
my_hash.each do |key, value|
  puts "  Key: #{key}, Value: #{value}"
end

# .times (simple integer loop)
puts "Using .times:"
3.times do |i|
  puts "  Iteration #{i}"
end

# .map (or .collect) - Creates a new array by transforming elements
numbers = [1, 2, 3, 4, 5]
squared_numbers = numbers.map do |n|
  n * n
end
puts "Original numbers: #{numbers.inspect}"
puts "Squared numbers (map): #{squared_numbers.inspect}"

# .select (or .find_all) - Creates a new array with elements passing a condition
even_numbers = numbers.select do |n|
  n.even? # Method check if number is even
end
puts "Even numbers (select): #{even_numbers.inspect}"

# .reject - Opposite of select
odd_numbers = numbers.reject do |n|
  n.even?
end
puts "Odd numbers (reject): #{odd_numbers.inspect}"

# .reduce (or .inject) - Accumulates a value
sum = numbers.reduce(0) do |accumulator, current_number|
  puts "  Accumulator: #{accumulator}, Current: #{current_number}" # Show process
  accumulator + current_number
end
puts "Sum of numbers (reduce): #{sum}"

# Shorthand using symbols and &: (if the block just calls one method)
upcased_fruits = fruits.map(&:upcase) # Equivalent to fruits.map { |f| f.upcase }
puts "Upcased fruits (shorthand): #{upcased_fruits.inspect}"

sum_shorthand = numbers.reduce(:+) # Equivalent to numbers.reduce(0) { |sum, n| sum + n }
puts "Sum (shorthand reduce): #{sum_shorthand}"


# ==============================================================================
# || 5. Methods (Functions) & Arguments                                       ||
# ==============================================================================
puts "\n--- 5. Methods ---"

# Basic method definition
def greet(name)
  # The last evaluated expression is implicitly returned
  "Hello, #{name}!"
end

puts greet("World")

# Method with default argument value
def say_hello(name = "Guest")
  puts "Hello, #{name}!"
end

say_hello # Uses default
say_hello("Alice") # Uses provided argument

# Method with multiple arguments
def add(a, b)
  return a + b # Explicit return keyword (optional here)
end

puts "Adding 3 + 5 = #{add(3, 5)}"

# Method with variable number of arguments (splat operator *)
def print_args(*args)
  puts "Arguments received: #{args.inspect}" # args becomes an array
end

print_args(1, "two", :three)

# Method with keyword arguments (order doesn't matter, more readable)
def create_user(name:, email:, age: nil) # age is optional keyword arg
  puts "Creating user:"
  puts "  Name: #{name}"
  puts "  Email: #{email}"
  puts "  Age: #{age}" if age # Print age only if provided
end

create_user(name: "Bob", email: "bob@example.com")
create_user(email: "charlie@example.com", name: "Charlie", age: 30)

# Method with double splat operator (**) for keyword arguments hash
def process_options(**options)
  puts "Processing options: #{options.inspect}" # options becomes a hash
end

process_options(color: "red", size: "large", count: 5)

# Combining argument types (order matters: required, optional, splat, keywords, double splat, block)
def complex_method(req1, req2, opt1 = "default", *args, key1:, key2: "default_key", **kwargs, &block)
 puts "req1: #{req1}, req2: #{req2}"
 puts "opt1: #{opt1}"
 puts "args: #{args.inspect}"
 puts "key1: #{key1}, key2: #{key2}"
 puts "kwargs: #{kwargs.inspect}"
 puts "Block given? #{block_given?}" # Check if a block was passed
 block.call("Data from method") if block_given? # Execute the block if provided
end

puts "--- Complex Method Call ---"
complex_method("R1", "R2", "OPT", 1, 2, 3, key1: "K1", extra_opt: true) do |data_from_method|
  puts "Block executed with: #{data_from_method}"
end
puts "--- End Complex Method Call ---"

# ==============================================================================
# || 6. Blocks, Procs, and Lambdas                                            ||
# ==============================================================================
puts "\n--- 6. Blocks, Procs, Lambdas ---"

# Blocks are chunks of code passed to methods. Used heavily for iteration (see above) and callbacks.
# Two syntaxes: do...end (multi-line) and { ... } (single-line)

# Method that accepts a block using `yield`
def run_my_block
  puts "Block Runner: Starting..."
  result = yield("Success") # Pass value to the block
  puts "Block Runner: Block returned: #{result}"
  puts "Block Runner: Finishing."
end

run_my_block do |status|
  puts "  Inside the block! Status received: #{status}"
  "Block Result Value" # This value is returned to the method
end

# Using {} syntax
run_my_block { |status| "Single line block. Status: #{status}" }

# Method explicitly defining a block argument (&block)
def run_explicit_block(&block)
  puts "Explicit Block Runner: Starting..."
  if block_given? # Good practice to check
    block.call("Data for block") # Call the block using .call
  else
    puts "Explicit Block Runner: No block provided."
  end
end

run_explicit_block # No block
run_explicit_block { |data| puts "  Explicit block received: #{data}" }

# Procs (Saved blocks, objects)
my_proc = Proc.new do |x|
  puts "Proc executing with: #{x}"
end

my_proc.call("Argument for Proc")
[10, 20].each(&my_proc) # Can pass a Proc where a block is expected using &

# Lambdas (Special kind of Proc)
# Differences from Procs:
# 1. Arity checking (strict about number of arguments)
# 2. Return behavior (`return` in lambda returns from lambda, `return` in Proc returns from the method it's defined in)

my_lambda = lambda { |name| puts "Lambda says hello to #{name}" }
# Alternate syntax: ->
my_stabby_lambda = ->(name) { puts "Stabby Lambda says hello to #{name}" }

my_lambda.call("Lambda User")
my_stabby_lambda.call("Stabby User")

# Demonstration of return behavior difference
def test_proc_return
  my_p = Proc.new { return "Returned from Proc (and method!)" }
  my_p.call
  "This line in test_proc_return is never reached." # Because the proc's return exits the method
end

def test_lambda_return
  my_l = lambda { return "Returned from Lambda only" }
  result = my_l.call
  "This line *is* reached in test_lambda_return. Lambda returned: #{result}"
end

puts test_proc_return # Output: "Returned from Proc (and method!)"
puts test_lambda_return # Output: "This line *is* reached... Lambda returned: Returned from Lambda only"

# Demonstration of arity difference
proc_arity = Proc.new { |a, b| puts "Proc Arity: a=#{a.inspect}, b=#{b.inspect}" }
lambda_arity = lambda { |a, b| puts "Lambda Arity: a=#{a}, b=#{b}" }

puts "Calling Proc with 1 arg (expects 2):"
proc_arity.call("one") # Works, b becomes nil

puts "Calling Lambda with 1 arg (expects 2):"
begin
  lambda_arity.call("one")
rescue ArgumentError => e
  puts "  Caught expected error: #{e}" # Raises ArgumentError
end


# ==============================================================================
# || 7. Recursion                                                             ||
# ==============================================================================
puts "\n--- 7. Recursion ---"

# Example: Factorial calculation using recursion
def factorial(n)
  if n < 0
    raise ArgumentError, "Factorial not defined for negative numbers"
  elsif n == 0 || n == 1
    1 # Base case
  else
    n * factorial(n - 1) # Recursive step
  end
end

puts "Factorial of 5: #{factorial(5)}" # 5 * 4 * 3 * 2 * 1 = 120
# puts "Factorial of -1: #{factorial(-1)}" # Would raise ArgumentError


# ==============================================================================
# || 8. Object-Oriented Programming (OOP)                                     ||
# ==============================================================================
puts "\n--- 8. OOP ---"

# --- Classes and Objects ---
class Animal
  # Class variable (shared among all instances of the class and subclasses)
  @@total_animals = 0

  # Attribute accessors (creates getter/setter methods)
  attr_accessor :name # Creates getter `name` and setter `name=`
  attr_reader :species # Creates only getter `species`
  # attr_writer :internal_state # Creates only setter `internal_state=`

  # Constructor method
  def initialize(name, species)
    @name = name         # Instance variable (unique to each object)
    @species = species
    @@total_animals += 1
    puts "Initialized a new #{@species}: #{@name}"
  end

  # Instance method
  def speak(sound = "makes a noise")
    "#{@name} the #{@species} #{sound}."
  end

  # Class method (called on the class itself, e.g., Animal.kingdom)
  def self.kingdom
    "Animalia"
  end

  def self.total_animals
    @@total_animals
  end

  # Visibility modifiers
  def public_method
    "This is public (default)."
  end

  protected
  # Protected methods can be called by other objects of the same class or subclasses
  def protected_method
    "This is protected."
  end

  private
  # Private methods can only be called implicitly by the object itself (cannot use `other_object.private_method`)
  def private_method
    "This is private."
  end

  def use_private_method
    "Calling private method internally: #{private_method}"
  end
end

# --- Inheritance ---
class Dog < Animal # Dog inherits from Animal
  attr_accessor :breed

  def initialize(name, breed)
    super(name, "Dog") # Calls the parent class's initialize method
    @breed = breed
  end

  # Overriding a method from the parent class
  def speak(sound = "Woof!")
    # Call the parent's version of the method if needed
    # parent_noise = super() # Calls Animal#speak
    # puts "Parent noise was: #{parent_noise}"
    "#{@name} the #{breed} says #{sound}"
  end

  def fetch
    "#{@name} is fetching!"
  end

  def interact_with(other_dog)
    # Can call protected methods on other instances of the same class/subclass
    puts "#{@name} sniffs #{other_dog.name}. It's a #{other_dog.protected_method}" # This works for protected
    # puts other_dog.private_method # This would fail (NoMethodError: private method called)
  end
end

# Create objects (instances)
generic_animal = Animal.new("Generic", "Creature")
dog1 = Dog.new("Buddy", "Golden Retriever")
dog2 = Dog.new("Lucy", "Labrador")

puts generic_animal.speak
puts dog1.speak # Overridden method
puts dog1.fetch
puts "Dog 1's name: #{dog1.name}" # Using attr_accessor getter
dog1.name = "Max" # Using attr_accessor setter
puts "Dog 1's name changed to: #{dog1.name}"
puts "Dog 1's species: #{dog1.species}" # Using attr_reader (inherited)
# dog1.species = "Canine" # This would fail (NoMethodError: undefined method `species=`)

puts "Kingdom: #{Animal.kingdom}" # Calling class method
puts "Total animals created: #{Animal.total_animals}" # Accessing class variable via class method

puts dog1.public_method
# puts dog1.protected_method # NoMethodError: protected method called for main
# puts dog1.private_method   # NoMethodError: private method called for main
puts dog1.use_private_method # Calling private method indirectly

puts "\nDog interaction:"
dog1.interact_with(dog2)

# --- Modules (Mixins and Namespacing) ---

# Module for Mixin (adding behavior to classes)
module Swimmable
  def swim
    "#{name} is swimming!" # Assumes the class including it has a `name` method
  end
end

module Flyable
  def fly
    "#{name} is flying!"
  end
end

class Fish < Animal
  include Swimmable # Mixin the Swimmable behavior

  def initialize(name)
    super(name, "Fish")
  end
end

class Duck < Animal
  include Swimmable
  include Flyable # Ducks can do both!

  def initialize(name)
    super(name, "Duck")
  end

  # Override speak for Duck
  def speak(sound = "Quack!")
    super(sound) # Call Animal#speak with the specific sound
  end
end

nemo = Fish.new("Nemo")
daffy = Duck.new("Daffy")

puts nemo.speak
puts nemo.swim
# puts nemo.fly # Error: Nemo can't fly

puts daffy.speak
puts daffy.swim
puts daffy.fly

puts "Total animals created now: #{Animal.total_animals}"

# Module for Namespacing (organizing code, preventing name collisions)
module Geometry
  PI = 3.14159 # Constant specific to this namespace

  class Circle
    attr_reader :radius
    def initialize(radius)
      @radius = radius
    end

    def area
      Geometry::PI * @radius * @radius # Access namespaced constant
    end
  end

  class Square
    attr_reader :side
    def initialize(side)
      @side = side
    end

    def area
      @side * @side
    end
  end
end

my_circle = Geometry::Circle.new(10)
my_square = Geometry::Square.new(5)

puts "Circle Area: #{my_circle.area}"
puts "Square Area: #{my_square.area}"
puts "Geometry PI: #{Geometry::PI}"
# puts PI # Accesses the top-level PI constant defined earlier


# ==============================================================================
# || 9. Error Handling (Exceptions)                                           ||
# ==============================================================================
puts "\n--- 9. Error Handling ---"

# begin / rescue / ensure / else
def risky_operation(divisor)
  begin
    puts "Attempting division by #{divisor}..."
    result = 10 / divisor
    puts "Result: #{result}" # This line runs only if no exception occurs
  rescue ZeroDivisionError => e # Catch specific error
    puts "Error: Cannot divide by zero! Details: #{e.message}"
    result = :error_division_by_zero # Set a default/error value
  rescue TypeError => e
    puts "Error: Invalid type for division! Details: #{e.message}"
    result = :error_type
  rescue => e # Catch any other standard error (subclass of StandardError)
    puts "An unexpected error occurred: #{e.class} - #{e.message}"
    result = :error_unexpected
  else
    # Executes only if NO exception was raised in the begin block
    puts "Operation successful (no exceptions)."
  # ensure
    # Executes ALWAYS, whether an exception occurred or not (like finally)
    puts "Ensuring cleanup happens..."
  end

  # Return the result or error indicator
  result
end

risky_operation(2)
puts "---"
risky_operation(0)
puts "---"
risky_operation("five")
puts "---"

# Raising custom exceptions
class MyCustomError < StandardError # Inherit from StandardError or a subclass
end

def check_value(value)
  raise MyCustomError, "Value cannot be negative!" if value < 0
  puts "Value #{value} is acceptable."
end

begin
  check_value(10)
  check_value(-5)
rescue MyCustomError => e
  puts "Caught custom error: #{e.message}"
end

# Retry mechanism
attempts = 0
max_attempts = 3
begin
  attempts += 1
  puts "Attempt ##{attempts} to perform fragile operation..."
  # Simulate a potentially failing operation
  raise "Operation failed!" if attempts < max_attempts
  puts "Operation succeeded on attempt ##{attempts}!"
rescue => e
  puts "  Caught error: #{e.message}"
  if attempts < max_attempts
    puts "  Retrying..."
    retry # Jumps back to the beginning of the 'begin' block
  else
    puts "  Max attempts reached. Giving up."
  end
end


# ==============================================================================
# || 10. Regular Expressions                                                  ||
# ==============================================================================
puts "\n--- 10. Regular Expressions ---"

text = "The quick brown fox jumps over the lazy dog. Phone: 123-456-7890"

# Basic matching using =~ (returns index of first match or nil)
if text =~ /fox/
  puts "Found 'fox' in the text."
end

if text =~ /cat/
  puts "Found 'cat' in the text." # This won't print
else
  puts "'cat' not found."
end

# Using .match method (returns MatchData object or nil)
match_data = text.match(/(\w+) (\d{3})-(\d{3})-(\d{4})/) # Match word then phone number pattern
if match_data
  puts "Phone number found!"
  puts "Full match: #{match_data[0]}"       # "Phone: 123-456-7890" (depends on regex specifics)
                                             # Adjusting regex for cleaner capture:
  match_data = text.match(/Phone: (\d{3}-\d{3}-\d{4})/)
  if match_data
     puts "Full match (Phone: Num): #{match_data[0]}" # "Phone: 123-456-7890"
     puts "Captured number: #{match_data[1]}" # "123-456-7890" (first capture group)
     # puts "Area code: #{match_data[2]}" # Example if using /(\d{3})-(\d{3})-(\d{4})/
  end
else
  puts "Phone number pattern not found."
end

# Using .scan to find all occurrences
words_with_o = text.scan(/\b\w*o\w*\b/i) # Find words containing 'o', case-insensitive
puts "Words containing 'o': #{words_with_o.inspect}"

# Using .gsub for substitution
censored_text = text.gsub(/\d{3}-\d{3}-\d{4}/, "[REDACTED]")
puts "Censored text: #{censored_text}"


# ==============================================================================
# || 11. File I/O (Basic)                                                     ||
# ==============================================================================
puts "\n--- 11. File I/O ---"

filename = "ruby_tour_test_file.txt"

# Writing to a file (overwrites existing content)
# Using block form ensures the file is closed automatically
begin
  File.open(filename, "w") do |file|
    file.puts "This is the first line written by the Ruby tour."
    file.write "This is the second line (no newline added by write)."
    file.puts " This is appended to the second line."
  end
  puts "Successfully wrote to #{filename}"

  # Reading from a file
  puts "Reading contents of #{filename}:"
  File.open(filename, "r") do |file|
    file.each_line do |line|
      print "  > #{line}" # print preserves original newlines
    end
  end

  # Simpler way to read the whole file
  puts "\nReading whole file at once:"
  content = File.read(filename)
  puts content

  # Appending to a file
  File.open(filename, "a") do |file|
    file.puts "Appending this line later."
  end
  puts "\nAppended to file. New content:"
  puts File.read(filename)

rescue SystemCallError => e
  puts "File operation failed: #{e.message}"
ensure
  # Clean up the test file if it exists
  File.delete(filename) if File.exist?(filename)
  puts "Cleaned up #{filename}"
end


# ==============================================================================
# || 12. Gems and Require                                                     ||
# ==============================================================================
puts "\n--- 12. Gems and Require ---"

# Ruby uses Gems for external libraries. Manage them with `gem` command or Bundler.
# `require` is used to load libraries (from Ruby standard library or installed gems).

# Example: Using the standard library JSON module
require 'json'

my_data = { name: "Ruby Gem Example", version: 1.0, items: [1, 2, 3] }
json_string = JSON.generate(my_data) # Or my_data.to_json

puts "Generated JSON: #{json_string}"

parsed_data = JSON.parse(json_string, symbolize_names: true) # symbolize_names converts string keys to symbols
puts "Parsed JSON back to Ruby Hash: #{parsed_data.inspect}"
puts "Accessing parsed data: #{parsed_data[:name]}"

# To use a gem not in the standard library (e.g., 'nokogiri' for HTML parsing):
# 1. Install it: `gem install nokogiri`
# 2. Require it: `require 'nokogiri'`
# (Actual Nokogiri usage omitted here to avoid external dependency for this example file)
puts "(Example: To use gems like 'nokogiri', first run 'gem install nokogiri', then 'require \"nokogiri\"' here.)"


# ==============================================================================
# || End of Tour                                                              ||
# ==============================================================================

puts "\n=================================="
puts "Ruby Language Tour Complete!"
