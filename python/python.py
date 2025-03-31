# comprehensive_python_overview.py
# -*- coding: utf-8 -*-

"""
This script is a comprehensive overview demonstrating various core features
of the Python programming language. It's intended as a reference or sampler,
not necessarily as a model for structuring a real-world application.
"""

# --- 1. Basic Syntax & Variables ---
# This is a single-line comment

"""
This is a
multi-line comment
(actually a docstring not assigned to anything)
"""

print("--- 1. Basic Syntax & Variables ---")

# Variable assignment (dynamic typing)
integer_var: int = 10        # Integer
float_var: float = 3.14      # Float
string_var: str = "Hello, Python!" # String
boolean_var: bool = True      # Boolean
none_var = None              # NoneType (representing absence of value)

# You can print variables and their types
print(f"Integer: {integer_var} (Type: {type(integer_var)})")
print(f"Float: {float_var} (Type: {type(float_var)})")
print(f"String: {string_var} (Type: {type(string_var)})")
print(f"Boolean: {boolean_var} (Type: {type(boolean_var)})")
print(f"None: {none_var} (Type: {type(none_var)})")
print("-" * 20)

# --- 2. Operators ---
print("--- 2. Operators ---")
a = 15
b = 4

# Arithmetic Operators
print(f"{a} + {b} = {a + b}")  # Addition
print(f"{a} - {b} = {a - b}")  # Subtraction
print(f"{a} * {b} = {a * b}")  # Multiplication
print(f"{a} / {b} = {a / b}")  # True Division
print(f"{a} // {b} = {a // b}") # Floor Division
print(f"{a} % {b} = {a % b}")   # Modulus (remainder)
print(f"{a} ** {b} = {a ** b}") # Exponentiation

# Comparison Operators
print(f"{a} > {b}: {a > b}")
print(f"{a} == 15: {a == 15}")
print(f"{a} != {b}: {a != b}")

# Logical Operators
x = True
y = False
print(f"{x} and {y}: {x and y}")
print(f"{x} or {y}: {x or y}")
print(f"not {x}: {not x}")

# Assignment Operators
c = 5
c += 2  # Equivalent to c = c + 2
print(f"c after += 2: {c}")

# Identity Operators (is, is not) - checks if they are the same object in memory
list1 = [1, 2]
list2 = [1, 2]
list3 = list1
print(f"list1 is list2: {list1 is list2}") # False (different objects)
print(f"list1 == list2: {list1 == list2}") # True (same content)
print(f"list1 is list3: {list1 is list3}") # True (same object)

# Membership Operators (in, not in)
print(f"1 in list1: {1 in list1}")
print(f"3 not in list1: {3 not in list1}")
print("-" * 20)


# --- 3. Data Structures ---
print("--- 3. Data Structures ---")

# Lists (mutable, ordered sequence)
my_list: list[int | str] = [1, 2, "three", 4, 5]
my_list.append("six")
print(f"List: {my_list}")
print(f"List element at index 2: {my_list[2]}")
print(f"List slice [1:4]: {my_list[1:4]}")
my_list[0] = "ONE" # Modify element
print(f"Modified List: {my_list}")

# Tuples (immutable, ordered sequence)
my_tuple: tuple[int, ...] = (10, 20, 30, 20)
print(f"Tuple: {my_tuple}")
print(f"Tuple element at index 1: {my_tuple[1]}")
# my_tuple[0] = 5 # This would cause a TypeError

# Sets (mutable, unordered collection of unique elements)
my_set: set[int] = {1, 2, 3, 4, 4, 5} # Duplicates are ignored
print(f"Set: {my_set}")
my_set.add(6)
print(f"Set after add(6): {my_set}")
print(f"Is 3 in set? {3 in my_set}")

# Dictionaries (mutable, unordered collection of key-value pairs)
my_dict: dict[str, int | str] = {"name": "Alice", "age": 30, "city": "New York"}
print(f"Dictionary: {my_dict}")
print(f"Value for key 'name': {my_dict['name']}")
my_dict["email"] = "alice@example.com" # Add new key-value pair
my_dict["age"] = 31 # Update value
print(f"Updated Dictionary: {my_dict}")
print(f"Dictionary keys: {my_dict.keys()}")
print(f"Dictionary values: {my_dict.values()}")
print(f"Dictionary items: {my_dict.items()}")
print("-" * 20)

# --- 4. Control Flow ---
print("--- 4. Control Flow ---")

# If-Elif-Else statement
temperature = 25
if temperature > 30:
    print("It's hot!")
elif 15 <= temperature <= 30:
    print("It's pleasant.")
else:
    print("It's cold!")

# For loop (iterating over a sequence)
print("Iterating over a list:")
for item in my_list:
    print(f"  Item: {item}")

# For loop with range()
print("Iterating with range:")
for i in range(5): # 0 to 4
    print(f"  Range value: {i}")

# While loop
count = 0
print("While loop demo:")
while count < 3:
    print(f"  Count is {count}")
    count += 1

# Break and Continue
print("Loop with break/continue:")
for i in range(10):
    if i == 3:
        print("  Continuing...")
        continue # Skip the rest of this iteration
    if i == 7:
        print("  Breaking...")
        break # Exit the loop entirely
    print(f"  Current number: {i}")
else:
    # This else block executes ONLY if the loop completed WITHOUT hitting break
    print("  Loop finished naturally (this won't print in this case)")

# Pass statement (acts as a placeholder)
if temperature > 100:
    pass # Do nothing for now
else:
    print("Temperature is not extreme.")

print("-" * 20)

# --- 5. Functions ---
print("--- 5. Functions ---")

# Basic function definition
def greet(name: str) -> str:
    """This function greets the person passed in as a parameter."""
    return f"Hello, {name}!"

message = greet("Bob")
print(message)
print(f"Docstring of greet function: {greet.__doc__}")

# Function with default arguments
def power(base: float, exponent: float = 2) -> float:
    """Calculates base raised to the power of exponent (default is 2)."""
    return base ** exponent

print(f"power(3): {power(3)}")         # Uses default exponent 2
print(f"power(3, 3): {power(3, 3)}")   # Specifies exponent 3
print(f"power(exponent=4, base=2): {power(exponent=4, base=2)}") # Keyword arguments

# Function with variable number of arguments (*args) and keyword arguments (**kwargs)
def process_data(*args: int | str, **kwargs: int | str) -> None:
    """Processes variable positional and keyword arguments."""
    print("Positional arguments (*args):")
    for arg in args:
        print(f"  - {arg}")
    print("Keyword arguments (**kwargs):")
    for key, value in kwargs.items():
        print(f"  - {key}: {value}")

process_data(1, "apple", 3.14, name="Charlie", status="active", id=123)

# Scope (Local vs Global)
global_var = "I am global"

def scope_test():
    local_var = "I am local"
    print(f"Inside function: {local_var}")
    print(f"Inside function accessing global: {global_var}")
    # To modify a global variable inside a function, use 'global' keyword
    # global global_var
    # global_var = "Modified global"

scope_test()
print(f"Outside function: {global_var}")
# print(local_var) # This would cause a NameError because local_var is local to the function

print("-" * 20)

# --- 6. Recursion ---
print("--- 6. Recursion ---")

def factorial(n: int) -> int:
    """Calculates factorial recursively."""
    if not isinstance(n, int) or n < 0:
        raise ValueError("Factorial requires a non-negative integer")
    if n == 0 or n == 1:
        return 1 # Base case
    else:
        return n * factorial(n - 1) # Recursive step

print(f"Factorial of 5: {factorial(5)}")
# print(f"Factorial of -1: {factorial(-1)}") # This would raise the ValueError
print("-" * 20)

# --- 7. Object-Oriented Programming (OOP) ---
print("--- 7. Object-Oriented Programming (OOP) ---")

# Define a base class
class Animal:
    # Class attribute (shared by all instances)
    classification = "Unknown"

    # Constructor (__init__ method)
    def __init__(self, name: str, species: str):
        # Instance attributes (specific to each instance)
        self._name = name # Convention: _ prefix suggests protected (internal use)
        self.__species = species # Convention: __ prefix triggers name mangling (more private)
        print(f"Animal '{self._name}' ({self.__species}) created.")

    # Instance method
    def speak(self) -> str:
        return "Some generic animal sound"

    # Another instance method accessing "private" attribute
    def get_species(self) -> str:
        return self.__species

    # String representation (__str__ method)
    def __str__(self) -> str:
        return f"{self._name} the {self.__species}"

    # Static method (doesn't depend on class or instance state)
    @staticmethod
    def is_living_thing() -> bool:
        return True

    # Class method (receives class itself as first argument)
    @classmethod
    def get_classification(cls) -> str:
        return cls.classification

# Define a derived class (Inheritance)
class Dog(Animal):
    # Override class attribute
    classification = "Mammal"

    def __init__(self, name: str, breed: str):
        # Call the base class constructor
        super().__init__(name, species="Dog")
        self._breed = breed # Add specific attribute for Dog
        print(f"Dog '{self._name}' of breed '{self._breed}' created.")

    # Override the speak method (Polymorphism)
    def speak(self) -> str:
        return "Woof! Woof!"

    # Dog-specific method
    def fetch(self) -> str:
        return f"{self._name} is fetching!"

# Create instances (objects)
generic_animal = Animal("Generic", "Creature")
my_dog = Dog("Buddy", "Golden Retriever")

# Access attributes and call methods
print(f"Generic animal's name: {generic_animal._name}")
# print(generic_animal.__species) # AttributeError: '_Animal__species' (due to name mangling)
print(f"Generic animal's species: {generic_animal.get_species()}")
print(f"Dog's name: {my_dog._name}")
print(f"Dog's species: {my_dog.get_species()}")
print(f"Dog's breed: {my_dog._breed}")

print(f"Generic animal says: {generic_animal.speak()}")
print(f"Dog says: {my_dog.speak()}") # Uses overridden method
print(my_dog.fetch())

# Print objects (uses __str__)
print(f"Generic animal object: {generic_animal}")
print(f"Dog object: {my_dog}")

# Access class/static methods
print(f"Is Animal a living thing? {Animal.is_living_thing()}") # Call on class
print(f"Is Dog a living thing? {my_dog.is_living_thing()}")     # Call on instance
print(f"Animal classification: {Animal.get_classification()}")
print(f"Dog classification: {Dog.get_classification()}")       # Uses overridden class attribute
print(f"Instance Dog classification: {my_dog.get_classification()}")

print("-" * 20)

# --- 8. Error Handling ---
print("--- 8. Error Handling ---")

try:
    # Code that might raise an exception
    # result = 10 / 0
    result = int("abc")
except ZeroDivisionError:
    print("Error: Cannot divide by zero!")
except ValueError:
    print("Error: Invalid value for conversion!")
except Exception as e: # Catch any other exceptions (generally be more specific)
    print(f"An unexpected error occurred: {e} (Type: {type(e)})")
else:
    # Executes only if the try block completes without raising an exception
    print(f"Operation successful, result: {result}")
finally:
    # Always executes, regardless of whether an exception occurred or not
    print("Finally block always runs (e.g., for cleanup).")

# Raising an exception
def check_age(age: int):
    if age < 0:
        raise ValueError("Age cannot be negative.")
    elif age < 18:
        print("User is a minor.")
    else:
        print("User is an adult.")

try:
    check_age(25)
    check_age(-5)
except ValueError as e:
    print(f"Caught expected error: {e}")

print("-" * 20)

# --- 9. Modules and Imports ---
print("--- 9. Modules and Imports ---")

# Import entire module
import math
print(f"Square root of 16: {math.sqrt(16)}")
print(f"Value of pi: {math.pi}")

# Import specific items from a module
from random import choice, randint
print(f"Random integer between 1 and 10: {randint(1, 10)}")
my_fruits = ["apple", "banana", "cherry"]
print(f"Random fruit choice: {choice(my_fruits)}")

# Import with an alias
import datetime as dt
now = dt.datetime.now()
print(f"Current date and time: {now}")

print("-" * 20)

# --- 10. File I/O ---
print("--- 10. File I/O ---")

file_path = "sample_file.txt"

# Writing to a file using 'with' (ensures file is closed automatically)
try:
    with open(file_path, "w", encoding="utf-8") as f:
        f.write("This is the first line.\n")
        f.write("This is the second line.\n")
        f.write("File handling is important.\n")
    print(f"Successfully wrote to {file_path}")

    # Reading from a file
    print(f"Reading from {file_path}:")
    with open(file_path, "r", encoding="utf-8") as f:
        # Read entire file content
        # content = f.read()
        # print(content)

        # Or read line by line
        for line in f:
            print(f"  - {line.strip()}") # strip() removes leading/trailing whitespace/newline

except IOError as e:
    print(f"An error occurred during file I/O: {e}")
finally:
    # Clean up the created file (optional, for demo purposes)
    import os
    if os.path.exists(file_path):
        # os.remove(file_path)
        print(f"(Keeping {file_path} for inspection)")
        pass # Comment out os.remove if you want to inspect the file

print("-" * 20)


# --- 11. List Comprehensions & Generator Expressions ---
print("--- 11. List Comprehensions & Generator Expressions ---")

# List comprehension (concise way to create lists)
numbers = [1, 2, 3, 4, 5, 6]
squares = [n**2 for n in numbers]
print(f"Original numbers: {numbers}")
print(f"Squares (list comprehension): {squares}")

even_squares = [n**2 for n in numbers if n % 2 == 0]
print(f"Even squares only: {even_squares}")

# Dictionary comprehension
square_dict = {n: n**2 for n in numbers}
print(f"Number-square dictionary: {square_dict}")

# Set comprehension
unique_squares = {n**2 for n in [1, 2, 2, 3, 3, 3]}
print(f"Unique squares set: {unique_squares}")

# Generator expression (creates an iterator, memory efficient for large sequences)
# Note: uses () instead of []
squares_gen = (n**2 for n in numbers)
print(f"Generator expression object: {squares_gen}")
print("Iterating through generator:")
for sq in squares_gen:
    print(f"  - Generated square: {sq}")
# Note: A generator can only be iterated over once. Trying again will yield nothing.

print("-" * 20)


# --- 12. Lambdas (Anonymous Functions) ---
print("--- 12. Lambdas (Anonymous Functions) ---")

# Simple lambda function
add = lambda x, y: x + y
print(f"Lambda add(5, 3): {add(5, 3)}")

# Using lambda with higher-order functions like map() and filter()
nums = [1, 2, 3, 4, 5, 6]

# Map: Apply a function to every item in an iterable
doubled_nums = list(map(lambda x: x * 2, nums))
print(f"Doubled numbers (using map+lambda): {doubled_nums}")

# Filter: Filter items based on a function that returns True/False
even_nums = list(filter(lambda x: x % 2 == 0, nums))
print(f"Even numbers (using filter+lambda): {even_nums}")

# Sorting a list of dictionaries using a lambda for the key
people = [
    {'name': 'Charlie', 'age': 35},
    {'name': 'Alice', 'age': 30},
    {'name': 'Bob', 'age': 40}
]
people.sort(key=lambda person: person['age'])
print(f"People sorted by age: {people}")

print("-" * 20)

# --- 13. Decorators ---
print("--- 13. Decorators ---")

# A decorator is a function that takes another function and extends
# its behavior without explicitly modifying it.

def my_decorator(func):
    def wrapper(*args, **kwargs):
        print("Something is happening before the function is called.")
        result = func(*args, **kwargs) # Call the original function
        print("Something is happening after the function is called.")
        return result
    return wrapper

# Apply the decorator using the @ syntax
@my_decorator
def say_whee(name: str):
    print(f"Whee, {name}!")
    return f"Whee indeed, {name}!"

# Call the decorated function
return_val = say_whee("Decorators")
print(f"Return value from decorated function: {return_val}")

# Equivalent non-decorator syntax (for understanding):
# def say_hello_again():
#     print("Hello again!")
# say_hello_again = my_decorator(say_hello_again) # Manually wrap it
# say_hello_again()

print("-" * 20)

# --- 14. Type Hinting (already used throughout) ---
print("--- 14. Type Hinting ---")
print("Type hints (like 'name: str' or '-> int') were used throughout this script.")
print("They are optional but improve code readability and allow static analysis.")

def hinted_function(param1: int, param2: str) -> bool:
    """Example function signature with type hints."""
    print(f"Received int: {param1}, str: {param2}")
    return len(param2) > param1

result_bool: bool = hinted_function(5, "Example")
print(f"Hinted function returned: {result_bool}")

print("-" * 20)

# --- End of Comprehensive Overview ---
print("--- End of Comprehensive Python Overview ---")
print("This script demonstrated many core Python concepts.")
print("Explore the standard library and third-party packages for more power!")

# Example of getting user input (often used in simple scripts)
# try:
#     user_name = input("Enter your name (optional): ")
#     if user_name:
#         print(f"Thanks for running the script, {user_name}!")
#     else:
#         print("Thanks for running the script!")
# except EOFError: # Handle cases where input stream is closed (e.g., piping)
#     print("\nInput stream closed.")
