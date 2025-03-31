--[[
================================================================================
 Comprehensive Lua Syntax and Concepts Demonstration
================================================================================

 This script aims to demonstrate a wide range of Lua features in a single file.
 It covers basic syntax, data types, control flow, functions, tables, OOP concepts,
 modules, coroutines, error handling, and some standard library usage.

 Run this file with a Lua interpreter (e.g., `lua comprehensive_lua.lua`)
 to see the output and understand the explanations.
--]]

-- suppress unnecessary prints from modules/libs if any for cleaner demo output
local _print = print
local function print_section(title)
    _print("\n" .. string.rep("=", 60))
    _print("-- " .. title)
    _print(string.rep("=", 60))
end

local function print(...)
    io.stdout:write("  ") -- Indent output for readability
    _print(...)
end


print_section("1. Basic Syntax, Comments, and Variables")

-- This is a single-line comment

--[[
This is a
multi-line comment.
--]]

-- Variables: Lua is dynamically typed. You don't declare types.
local local_variable = "I am local to this script's main chunk" -- Preferred style
global_variable = "I am global (avoid unless necessary)" -- Accessible everywhere

-- Convention: Globals sometimes written in ALL_CAPS, but Lua has no enforcement
GLOBAL_CONSTANT_LIKE = 100

print("Local variable:", local_variable)
print("Global variable:", global_variable)

-- Blocks and Scope: Scope is defined by blocks (chunks, functions, loops, if statements)
do
  local inner_local = "I am local to this 'do' block"
  print("Inside block:", inner_local)
end
-- print(inner_local) -- This would cause an error, inner_local is out of scope


print_section("2. Data Types")

-- Lua has 8 basic types:
local type_nil = nil
local type_boolean_true = true
local type_boolean_false = false
local type_number_int = 10
local type_number_float = 3.14
local type_string1 = 'Single quotes'
local type_string2 = "Double quotes"
local type_string_multi = [[
This is a multi-line
string literal. It can contain "quotes" and 'apostrophes'.
]]
local type_function = function(x) return x * x end
local type_table = { key = "value", 10, 20, name = "Lua Table" } -- The versatile data structure
local type_userdata -- Represents C data (e.g., file handles from io.open). Cannot be created purely in Lua.
local type_thread -- Represents coroutines

print("Type of nil:", type(type_nil))
print("Type of true:", type(type_boolean_true))
print("Type of 10:", type(type_number_int))
print("Type of 3.14:", type(type_number_float))
print("Type of 'hello':", type(type_string1))
print("Type of function:", type(type_function))
print("Type of table:", type(type_table))
print("Type of io.stdout (userdata):", type(io.stdout)) -- Example of userdata
print("Type of coroutine:", type(coroutine.create(function() end))) -- Example of thread

-- Type coercion: String to number (explicitly)
local num_str = "123"
local num = tonumber(num_str)
print("String '123' converted to number:", num, type(num))
-- Automatic coercion in some contexts (e.g., arithmetic)
print("'5' + 10 =", '5' + 10) -- Lua coerces '5' to a number here


print_section("3. Operators")

-- Arithmetic
local a = 10
local b = 3
print("Arithmetic:", a + b, a - b, a * b, a / b, a % b, a ^ b) -- + - * / % (modulo) ^ (exponentiation)

-- Relational (Comparison)
print("Relational:", a > b, a < b, a >= b, a <= b, a == b, a ~= b) -- ~= means 'not equal'

-- Logical
local t, f = true, false
print("Logical AND:", t and f) -- false (short-circuits)
print("Logical OR:", t or f)   -- true (short-circuits)
print("Logical NOT:", not t)   -- false
-- Note: Lua treats `false` and `nil` as false in logical contexts, everything else is true.
print("0 is true in Lua logic:", 0 and true) -- Output: true (because 0 is not false or nil)
print("nil is false:", nil or "default") -- Output: default

-- Concatenation
local str1 = "Hello"
local str2 = " Lua"
print("Concatenation:", str1 .. str2 .. "!") -- Output: Hello Lua!

-- Length Operator (#) - Works on strings and sequence-like tables
print("Length of '" .. str1 .. "':", #str1)
local seq_table = { 10, 20, 30 }
print("Length of {10, 20, 30}:", #seq_table)
local hash_table = { x=1, y=2 }
print("Length of {x=1, y=2}:", #hash_table) -- Result is often 0 for non-sequence tables


print_section("4. Control Structures")

-- If / Then / Elseif / Else
local score = 75
if score >= 90 then
  print("Grade: A")
elseif score >= 80 then
  print("Grade: B")
elseif score >= 70 then
  print("Grade: C")
else
  print("Grade: Needs Improvement")
end

-- While loop
local counter = 3
print("While loop:")
while counter > 0 do
  print("  Counter:", counter)
  counter = counter - 1
end

-- Repeat / Until loop (Condition checked at the end, loop always runs at least once)
local attempts = 0
print("Repeat/Until loop:")
repeat
  attempts = attempts + 1
  print("  Attempt:", attempts)
until attempts >= 2

-- For loop (numeric)
print("Numeric For loop:")
for i = 1, 5, 2 do -- Start, End, Step (optional, default 1)
  print("  i =", i)
end
-- Decrementing loop
print("Decrementing For loop:")
for i = 3, 1, -1 do
    print("  i =", i)
end

-- For loop (generic) - Iterating over tables
local my_table = { name = "Lua", version = 5.4, is_cool = true, [1] = "first", [2] = "second" }
print("Generic For loop (pairs - key/value):")
for key, value in pairs(my_table) do
  print("  Key:", key, "| Value:", value)
end

local array_table = { "apple", "banana", "cherry" }
print("Generic For loop (ipairs - integer index/value for sequences):")
-- `ipairs` iterates over integer keys 1, 2, 3, ... until a `nil` value is found.
for index, value in ipairs(array_table) do
  print("  Index:", index, "| Value:", value)
end

-- `break` exits a loop prematurely
print("Loop with break:")
for i=1, 10 do
    if i > 3 then
        print("  Breaking at i =", i)
        break
    end
    print("  i =", i)
end

-- `goto` (Use sparingly, often considered bad practice)
print("Goto example:")
goto my_label -- Jump forward
::skip_print::
print("  This will be skipped")
goto end_goto -- Jump forward again
::my_label::
print("  Jumped to my_label")
goto skip_print -- Jump backward (careful with loops!)
::end_goto::
print("  End of goto example")


print_section("5. Functions")

-- Defining a function
function greet(name)
  print("Hello, " .. name .. "!")
end

-- Calling a function
greet("World")

-- Functions are first-class values (can be stored in variables, passed around)
local my_greet = greet
my_greet("Alice")

-- Returning values (including multiple values)
function get_coordinates()
  return 10, 20, "Center" -- x, y, label
end

local x, y, label, extra = get_coordinates()
print("Coordinates:", x, y, label, extra) -- extra will be nil

-- Variable arguments (...)
function sum(...)
  local total = 0
  local args = { ... } -- Collect varargs into a table
  print("  Varargs received:", table.concat(args, ", "))
  for i, v in ipairs(args) do
    total = total + v
  end
  return total
end

print("Sum (varargs):", sum(1, 2, 3, 4, 5))

-- Named arguments (using tables) - a common pattern
function configure(options)
    local width = options.width or 80 -- Default value
    local height = options.height or 24
    print("Configuring with Width:", width, "Height:", height)
end

configure({ width = 100, height = 50 })
configure({ width = 120 }) -- height uses default
configure{} -- Use both defaults

-- Closures (Functions that capture variables from their enclosing scope)
function make_counter()
  local count = 0
  return function() -- This inner function is a closure
    count = count + 1
    return count
  end
end

local counter1 = make_counter()
local counter2 = make_counter()
print("Counter 1:", counter1(), counter1(), counter1()) -- 1 2 3
print("Counter 2:", counter2(), counter2())             -- 1 2 (independent count)

-- Recursion
function factorial(n)
  if n <= 1 then
    return 1
  else
    return n * factorial(n - 1)
  end
end

print("Factorial of 5:", factorial(5))

-- Tail Call Optimization (TCO)
-- Lua optimizes tail calls, avoiding stack overflow for deep recursion if written correctly
-- This `factorial` is NOT tail-recursive. Here's a tail-recursive version:
function factorial_tailrec(n, accumulator)
    accumulator = accumulator or 1 -- Default value for first call
    if n <= 1 then
        return accumulator
    else
        -- The recursive call is the *very last* action.
        return factorial_tailrec(n - 1, n * accumulator)
    end
end
print("Factorial (tail recursive) of 5:", factorial_tailrec(5))
-- print("Factorial (tail recursive) of 10000:", factorial_tailrec(10000)) -- Would likely work due to TCO


print_section("6. Tables - The Universal Data Structure")

-- Creating tables
local empty_table = {}
local array_like = { 10, "hello", true } -- Indices 1, 2, 3
local dictionary_like = { x = 1, y = 2, ["key with spaces"] = 3 }
local mixed = { "value1", "value2", name = "Mixed Table", [5] = "value_at_5" }

-- Accessing elements
print("Array-like[2]:", array_like[2]) -- Output: hello
print("Dictionary-like.x:", dictionary_like.x) -- Dot syntax for valid identifiers
print("Dictionary-like[\"y\"]:", dictionary_like["y"]) -- Bracket syntax for any string key
print("Dictionary-like[\"key with spaces\"]:", dictionary_like["key with spaces"])
print("Mixed[1]:", mixed[1]) -- Output: value1
print("Mixed.name:", mixed.name) -- Output: Mixed Table
print("Mixed[5]:", mixed[5]) -- Output: value_at_5
print("Mixed[3] (non-existent):", mixed[3]) -- Output: nil

-- Modifying tables
mixed[1] = "new_value1"
mixed.name = "Updated Name"
mixed.new_key = "I was added later"
mixed[5] = nil -- Removes the element at index 5

print("Modified mixed table:")
for k, v in pairs(mixed) do print("  ", k, "=", v) end

-- Table library functions (a few examples)
local sequence = { "a", "b", "c" }
table.insert(sequence, "d") -- Insert at the end
print("After insert:", table.concat(sequence, ", "))
table.insert(sequence, 2, "X") -- Insert at index 2
print("After insert at index 2:", table.concat(sequence, ", "))
local removed_element = table.remove(sequence, 3) -- Remove element at index 3 ("b")
print("After remove index 3:", table.concat(sequence, ", "), "| Removed:", removed_element)
table.sort(sequence)
print("Sorted sequence:", table.concat(sequence, ", "))


print_section("7. Metatables and Basic OOP")

-- Metatables allow you to change the behavior of tables (e.g., operator overloading, inheritance)
-- Metamethods are special keys in a metatable (e.g., __index, __tostring)

-- Example: Simple Vector class using metatables for OOP
local Vector = {}
Vector.__index = Vector -- Crucial for inheritance/method lookup

-- Constructor
function Vector:new(x, y) -- Colon syntax provides 'self' automatically
  local instance = { x = x or 0, y = y or 0 }
  setmetatable(instance, self) -- Make instance behave like a Vector
  -- self.__index = self -- Alternative way to set __index within constructor if needed
  return instance
end

-- Method definition (using colon syntax)
function Vector:magnitude()
  -- 'self' refers to the instance (the table the method was called on)
  return math.sqrt(self.x^2 + self.y^2)
end

-- Metamethod: __tostring (controls how `print()` or `tostring()` represents the object)
function Vector:__tostring()
  return "Vector(" .. self.x .. ", " .. self.y .. ")"
end

-- Metamethod: __add (operator overloading for '+')
function Vector:__add(other)
  -- Creates a *new* Vector for the result
  return Vector:new(self.x + other.x, self.y + other.y)
end

-- Create instances
local v1 = Vector:new(3, 4)
local v2 = Vector:new(1, 2)

-- Use methods and metamethods
print("v1:", v1) -- Uses __tostring
print("v2:", v2)
print("Magnitude of v1:", v1:magnitude()) -- Calls the magnitude method
print("v1 + v2:", v1 + v2) -- Uses __add metamethod

-- How __index works:
-- If you try `v1.some_key` and `v1` doesn't have `some_key`,
-- Lua checks `getmetatable(v1)`.
-- If the metatable has an `__index` field:
--   If `__index` is a table (like `Vector` here), Lua looks for `some_key` in that table (`Vector.some_key`).
--   If `__index` is a function, Lua calls that function: `metatable.__index(v1, "some_key")`.
-- This allows method lookup (e.g., `v1:magnitude()` finds `Vector.magnitude`).

-- Metamethod: __newindex (controls assignment to non-existent keys)
local mt_guard = {}
mt_guard.__newindex = function(table, key, value)
    print("Attempted to set key '" .. tostring(key) .. "' to '" .. tostring(value) .. "', but this table is guarded.")
    -- rawset(table, key, value) -- Use rawset to bypass the __newindex if you actually want to set it
end

local guarded_table = {}
setmetatable(guarded_table, mt_guard)
guarded_table.x = 10 -- Triggers __newindex
guarded_table.y = 20 -- Triggers __newindex
print("Guarded table x (was not set):", guarded_table.x) -- nil


print_section("8. Modules")

-- Modules help organize code into reusable libraries.
-- A module is typically a Lua file that returns a table containing its public functions/data.

-- Simulate defining a module (normally this would be in 'my_module.lua')
-- File: my_module.lua (simulation) -----
local M = {} -- The module table

local private_data = "Secret"

function M.public_function(name)
    print("Hello from the module, " .. name .. "! Private data says: " .. private_data)
end

function M.calculate(a, b)
    return a + b
end

-- return M -- This is the crucial part in a real module file
-- End of my_module.lua simulation -----

-- Simulate using the module (normally you'd use `require`)
-- Assume 'my_module.lua' exists and returns the table `M` above.
-- local my_module = require("my_module") -- This is how you'd load it.

-- For this demo, we'll just use the 'M' table directly.
local my_module = M -- Simulating the result of require("my_module")

print("Using the 'simulated' module:")
my_module.public_function("User")
local result = my_module.calculate(5, 7)
print("Module calculation result:", result)
-- print(my_module.private_data) -- Error: private_data is local to the module file, not part of the returned table M.


print_section("9. Coroutines (Cooperative Multitasking)")

-- Coroutines allow functions to pause (yield) and resume execution later.

function producer()
    local values = {"data1", "data2", "data3"}
    for i, v in ipairs(values) do
        print("Producer: Yielding", v)
        coroutine.yield(v) -- Pause and send 'v' back to the resumer
    end
    print("Producer: Finished")
    return "Producer done" -- Final return value
end

-- Create a coroutine (but don't run it yet)
local co = coroutine.create(producer)

print("Coroutine status:", coroutine.status(co)) -- suspended

-- Resume the coroutine
print("Resuming coroutine...")
local status, value = coroutine.resume(co)
print("Resume 1 - Status:", status, "Value:", value) -- true, data1
print("Coroutine status:", coroutine.status(co)) -- suspended

print("Resuming coroutine...")
status, value = coroutine.resume(co)
print("Resume 2 - Status:", status, "Value:", value) -- true, data2
print("Coroutine status:", coroutine.status(co)) -- suspended

print("Resuming coroutine...")
status, value = coroutine.resume(co)
print("Resume 3 - Status:", status, "Value:", value) -- true, data3
print("Coroutine status:", coroutine.status(co)) -- suspended

print("Resuming coroutine...")
status, value = coroutine.resume(co) -- Producer finishes now
print("Resume 4 - Status:", status, "Value:", value) -- true, "Producer done" (the return value)
print("Coroutine status:", coroutine.status(co)) -- dead

-- Try resuming a dead coroutine
print("Resuming dead coroutine...")
status, value = coroutine.resume(co)
print("Resume 5 - Status:", status, "Value:", value) -- false, "cannot resume dead coroutine" (error message)


print_section("10. Error Handling")

-- `error(message, level)`: Raises an error. `level` controls where the error message points (1=error call, 2=caller of error, etc.)
function cause_error()
    -- error("Something went wrong!", 2) -- Level 2 points error to where cause_error was called
    print("This will not be printed if error above is uncommented.")
end

-- `assert(condition, message)`: Checks condition. If false or nil, raises an error with the message.
function check_value(val)
    assert(type(val) == "number", "Value must be a number")
    print("Value is valid:", val)
end

-- `pcall(function, arg1, ...)`: Protected call. Executes the function in protected mode.
-- Returns `true, result1, ...` on success.
-- Returns `false, error_message` on error.
print("Testing pcall:")
local success, result_or_error = pcall(function(a, b)
                                          -- check_value("not a number") -- Uncomment to test assert inside pcall
                                          -- cause_error() -- Uncomment to test error() inside pcall
                                          if b == 0 then error("Division by zero") end
                                          return a / b
                                      end, 10, 2) -- Arguments passed to the function

if success then
    print("  Pcall Succeeded! Result:", result_or_error)
else
    print("  Pcall Failed! Error:", result_or_error)
end

-- Test pcall with division by zero error
success, result_or_error = pcall(function(a,b) if b == 0 then error("div zero") end return a/b end, 10, 0)
if success then print("  Pcall Succeeded! Result:", result_or_error) else print("  Pcall Failed! Error:", result_or_error) end

-- `xpcall(function, error_handler_function, arg1, ...)`: Like pcall, but allows a custom error handler function.
print("Testing xpcall:")
local function my_error_handler(err_msg)
    print("  XPCall Error Handler Triggered!")
    print("  Original error:", err_msg)
    return "Processed error: " .. err_msg -- The error handler's return value becomes xpcall's error result
end

success, result_or_error = xpcall(function() error("xpcall test error") end, my_error_handler)

if success then
    print("  Xpcall Succeeded! Result:", result_or_error)
else
    print("  Xpcall Failed! Error from handler:", result_or_error)
end

-- Using assert
print("Testing assert:")
check_value(123)
-- check_value("abc") -- Uncomment this line to see assert trigger an error (which would stop the script if not in pcall)


print_section("11. Standard Libraries (Brief Examples)")

-- Lua has several built-in libraries. You don't need to 'import' them like in some languages.

-- `math` library
print("Math library:")
print("  Pi:", math.pi)
print("  Sin(pi/2):", math.sin(math.pi / 2))
print("  Random number:", math.random()) -- Random float between 0 and 1
print("  Random integer (1-10):", math.random(1, 10))
math.randomseed(os.time()) -- Seed the random generator
print("  Random after seeding:", math.random())

-- `string` library
print("String library:")
local sample_string = "Lua is Awesome!"
print("  Uppercase:", string.upper(sample_string))
print("  Substring (5-6):", string.sub(sample_string, 5, 6)) -- "is" (indices are 1-based)
print("  Find 'Awesome':", string.find(sample_string, "Awesome")) -- Returns start and end indices
local name, version = "Lua", 5.4
print("  Formatted string:", string.format("Welcome to %s version %.1f", name, version))
print("  String repetition:", string.rep("-", 10))
print("  Global substitution (gsub):", string.gsub(sample_string, "s", "S")) -- Returns new string and number of replacements

-- `io` library (Basic File I/O)
print("IO library (File Operations):")
local file_name = "lua_demo_output.txt"
-- Write to a file
local file, err = io.open(file_name, "w") -- Open in write mode
if file then
    print("  Writing to", file_name)
    file:write("This is line 1.\n")
    file:write(string.format("Data written at %s\n", os.date()))
    file:close()
else
    print("  Error opening file for writing:", err)
end

-- Read from a file
file, err = io.open(file_name, "r") -- Open in read mode
if file then
    print("  Reading from", file_name)
    local content = file:read("*a") -- Read the whole file ("*all")
    print("  File content:\n", content)
    file:close()
    -- os.remove(file_name) -- Uncomment to clean up the file afterwards
else
    print("  Error opening file for reading:", err)
end

-- `os` library
print("OS library:")
print("  Current time (seconds since epoch):", os.time())
print("  Formatted date/time:", os.date("%Y-%m-%d %H:%M:%S"))
print("  CPU time used (approx):", os.clock())
-- os.exit(0) -- Exits the script


print_section("12. Garbage Collection (GC)")

print("Garbage Collection:")
print("  Lua performs automatic memory management using garbage collection.")
print("  You typically don't need to free memory manually for Lua objects (tables, functions, strings, etc.).")
print("  Unreachable objects are eventually collected.")
print("  The `collectgarbage()` function can be used to interact with the GC (e.g., force a cycle, get memory usage), but it's often not needed in application code.")
local mem_before = collectgarbage("count") -- Get memory usage in KB
local temp_table = {}
for i = 1, 10000 do temp_table[i] = "some string " .. i end
local mem_after = collectgarbage("count")
print(string.format("  Memory used before creating large table: %.2f KB", mem_before))
print(string.format("  Memory used after creating large table:  %.2f KB", mem_after))
temp_table = nil -- Make the table unreachable
collectgarbage("collect") -- Request a full garbage collection cycle
local mem_collected = collectgarbage("count")
print(string.format("  Memory used after GC:                %.2f KB", mem_collected))


print_section("End of Comprehensive Lua Demonstration")
print("This script covered many core aspects of the Lua language.")
print("Refer to the official Lua documentation (www.lua.org/manual/) for complete details.")
