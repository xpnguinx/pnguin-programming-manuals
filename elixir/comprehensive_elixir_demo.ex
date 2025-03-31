# comprehensive_elixir_demo.ex
# FINAL VERSION: Added underscores to silence unused variable warnings.

defmodule ComprehensiveElixirDemo do
  @moduledoc """
  This module showcases various Elixir features.
  The module body now contains only definitions.
  Call ComprehensiveElixirDemo.run() to execute the examples.
  Warnings about unreachable 'case' clauses are expected due to fixed input.
  """

  # === Definitions First ===

  # --- 9. Struct Definition ---
  defmodule User do
    @enforce_keys [:name]
    defstruct name: nil, age: 0, city: "Unknown"
  end

  # --- 10. Protocol Definition and Implementations ---
  defprotocol Size do
    @doc "Calculates the size of a data structure."
    def size(data)
  end

  defimpl Size, for: List do
    def size(list), do: length(list)
  end

  defimpl Size, for: Tuple do
    def size(tuple), do: tuple_size(tuple)
  end

  defimpl Size, for: ComprehensiveElixirDemo.User do
    def size(user), do: String.length(user.name)
  end

  defimpl Size, for: BitString do
    def size(bitstring), do: byte_size(bitstring)
  end

  # --- 13. Metaprogramming Basics (Macro Definition) ---
  defmacro custom_unless(condition, clauses) do
    quote do
      if !unquote(condition) do
        unquote(clauses[:do])
      else
        unquote(clauses[:else] || nil)
      end
    end
  end

  # --- 12. OTP Basics (GenServer Definition) ---
  defmodule SimpleCounter do
    use GenServer
    # Client API
    def start_link(initial_state \\ 0), do: GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
    def increment(count \\ 1), do: GenServer.cast(__MODULE__, {:increment, count})
    def decrement(count \\ 1), do: GenServer.cast(__MODULE__, {:decrement, count})
    def value(), do: GenServer.call(__MODULE__, :value)
    # Server Callbacks
    @impl true
    def init(initial_state), do: (IO.puts "12. OTP (GenServer): Counter starting with state #{initial_state}"; {:ok, initial_state})
    @impl true
    def handle_call(:value, _from, state), do: {:reply, state, state}
    @impl true
    def handle_cast({:increment, count}, state), do: (new_state = state + count; IO.puts "12. OTP (GenServer): Incremented by #{count}. New state: #{new_state}"; {:noreply, new_state})
    @impl true
    def handle_cast({:decrement, count}, state), do: (new_state = state - count; IO.puts "12. OTP (GenServer): Decremented by #{count}. New state: #{new_state}"; {:noreply, new_state})
  end

  # --- 6. Modules and Functions (Definitions) ---
  @default_greeting "Hi"
  def greet(""), do: "#{@default_greeting} there!"
  def greet(name) when is_binary(name), do: "#{@default_greeting}, #{name}!"
  def add(a, b \\ 1), do: a + b
  # FIXED: Added underscore as function is unused
  defp _helper_function(data), do: {:internal, data}
  def factorial(0), do: 1
  def factorial(n) when n > 0 and is_integer(n), do: n * factorial(n - 1)
  def apply_twice(fun, value), do: fun.(fun.(value))

  # === Execution Function ===

  def run do
    IO.puts "\n--- Starting Comprehensive Elixir Demo Execution ---"

    # --- 1. Basic Syntax ---
    # FIXED: Added underscore as variable is unused after rebinding
    _variable = 10
    _variable = "Now I'm a string" # Rebinding demonstrated
    result = if true, do: :truthy, else: :falsy
    IO.puts "1. Basic Syntax: if expression result = #{inspect result}"
    # IO.puts "1. Basic Syntax: Rebound variable = #{inspect _variable}" # No need to print unused var

    # --- 2. Data Types ---
    status = :ok
    integer_num = 42
    float_num = 3.14
    hello = "world"
    greeting = "Hello, #{hello}!"
    # FIXED: Added underscore
    _long_string = """
    Multi-line
    String
    """
    # FIXED: Added underscore
    _binary_data = <<1, 2, 3, 255>>
    my_list = [1, :two, "three"]
    my_tuple = {:ok, "Data"}
    my_map = %{ "b" => 2, a: 1 }
    shorthand_map = %{name: "Alice", age: 30}
    # FIXED: Added underscore
    _name = shorthand_map[:name]
    options = [path: "/users", method: :get]
    # FIXED: Added underscore
    _path = options[:path]
    charlist = ~c"hello"
    num_range = 1..5
    regex = ~r/elixir/i
    IO.puts "2. Data Types: Atom=#{inspect status}, Int=#{integer_num}, Float=#{float_num}"
    IO.puts "2. Data Types: String=#{greeting}, List=#{inspect my_list}, Tuple=#{inspect my_tuple}"
    IO.puts "2. Data Types: Map=#{inspect my_map}, Keyword=#{inspect options}"
    IO.puts "2. Data Types: Charlists=#{inspect charlist}, Range=#{inspect num_range}, Regex=#{inspect regex}"

    # --- 3. Operators ---
    arithmetic = 1 + 2 * 3 / 4 - 5
    integer_division = div(10, 3)
    remainder = rem(10, 3)
    boolean_strict = true and false
    # FIXED: Added underscore
    _boolean_relaxed = 1 && nil
    # FIXED: Added underscore
    _comparison = 1 == 1.0
    # FIXED: Added underscore
    _strict_comparison = 1 === 1.0
    list_concat = [1, 2] ++ [3, 4]
    string_concat = "Hello" <> ", " <> "Elixir!"
    # FIXED: Added underscore
    _membership = 1 in [1, 2, 3]
    piped_result = " elIxIr " |> String.trim() |> String.upcase() |> String.split("", trim: true)
    IO.puts "3. Operators: Arithmetic=#{arithmetic}, Div/Rem=#{integer_division}/#{remainder}"
    IO.puts "3. Operators: Boolean strict=#{boolean_strict}" # Removed relaxed as unused
    IO.puts "3. Operators: Concat List=#{inspect list_concat}, String=#{string_concat}"
    IO.puts "3. Operators: Piped result = #{inspect piped_result}"

    # --- 4. Pattern Matching ---
    # FIXED: Added underscore to unused `b`
    {a, _b} = {:hello, 123}
    # FIXED: Added underscore to unused `tail`
    [head | _tail] = [1, 2, 3]
    %{name: person_name} = %{name: "Bob", city: "London"}
    existing_value = 10
    {^existing_value, y} = {10, 20}
    {:ok, _ignored, important} = {:ok, "ignore me", 99}
    IO.puts "4. Pattern Matching: a=#{a}, head=#{head}, person_name=#{person_name}, y=#{y}, important=#{important}"

    # --- 5. Control Flow ---
    number = 5
    if number > 10, do: (IO.puts "5. Control Flow: Number is large"), else: (IO.puts "5. Control Flow: Number is small or ten")
    unless number == 0, do: (IO.puts "5. Control Flow: Number is not zero (using Kernel.unless)")

    data = {:user, "Charlie", 25}
    # Note: The following two clauses will generate warnings because `data` is fixed.
    # This is expected in this demo context to illustrate the syntax.
    case data do
      {:ok, result} -> IO.puts "5. Control Flow (case): Operation successful with #{inspect result}" # Unreachable here
      {:error, reason} -> IO.puts "5. Control Flow (case): Operation failed: #{inspect reason}" # Unreachable here
      {:user, name, age} when age > 18 -> IO.puts "5. Control Flow (case): User #{name} is an adult."
      other_pattern -> IO.puts "5. Control Flow (case): Matched other pattern: #{inspect other_pattern}"
    end

    score = 75
    cond do
      score >= 90 -> IO.puts "5. Control Flow (cond): Grade A"
      score >= 70 -> IO.puts "5. Control Flow (cond): Grade B"
      score >= 50 -> IO.puts "5. Control Flow (cond): Grade C"
      true -> IO.puts "5. Control Flow (cond): Grade F"
    end

    result_with =
      with {:ok, val1} <- Map.fetch(%{a: 1}, :a),
           {:ok, val2} <- Map.fetch(%{b: 2}, :b),
           :ok <- (if val1 + val2 > 0, do: :ok, else: :error)
      do
        IO.puts "5. Control Flow (with): All steps successful. Sum = #{val1 + val2}"
        {:success, val1 + val2}
      else
        :error -> IO.puts "5. Control Flow (with): Condition failed."; {:failure, :condition_failed}
        {:error, reason} -> IO.puts "5. Control Flow (with): A fetch failed: #{inspect reason}"; {:failure, :key_not_found}
        other_error -> IO.puts "5. Control Flow (with): Unexpected intermediate result: #{inspect other_error}"; {:failure, :unknown}
      end
    IO.puts "5. Control Flow (with): Final result = #{inspect result_with}"

    try do
      IO.puts "5. Control Flow (try): Trying operation..."
      10 / 2
    rescue e in ArithmeticError -> IO.puts "5. Control Flow (rescue): Rescued ArithmeticError: #{inspect e}"; :rescued_arithmetic
           e in KeyError -> IO.puts "5. Control Flow (rescue): Rescued KeyError: #{inspect e}"; :rescued_key
    catch kind, value -> IO.puts "5. Control Flow (catch): Caught #{kind}: #{inspect value}"; :caught
    after IO.puts "5. Control Flow (after): Cleanup action executed."
    end

    # --- 6. Modules and Functions (Usage/Anonymous) ---
    IO.puts "6. Functions: Greet Dave = #{greet("Dave")}"
    IO.puts "6. Functions: Factorial 5 = #{factorial(5)}"
    multiply = fn a, b -> a * b end
    product = multiply.(5, 6)
    add_one = &(&1 + 1)
    sum_captured = &( &1 + &2 )
    # FIXED: Added underscore as sum_result is unused
    _sum_result = sum_captured.(10, 20)
    IO.puts "6. Functions: Anonymous multiply(5, 6) = #{product}"
    IO.puts "6. Functions: Captured add_one(99) = #{add_one.(99)}"
    IO.puts "6. Functions: Apply add_one twice to 5 = #{apply_twice(add_one, 5)}"

    # --- 7. Enumerables and Comprehensions ---
    numbers = [1, 2, 3, 4, 5]
    doubled = Enum.map(numbers, &(&1 * 2))
    evens = Enum.filter(numbers, &(rem(&1, 2) == 0))
    sum_enum = Enum.reduce(numbers, 0, &(&1 + &2))
    has_three? = Enum.member?(numbers, 3)
    Enum.each(1..3, fn i -> IO.puts "7. Enumerable: Looping with each: #{i}" end)
    squared_odds = for x <- numbers, rem(x, 2) != 0, do: x * x
    map_from_comp = for x <- numbers, into: %{}, do: {:"num_#{x}", x}
    IO.puts "7. Enumerable: Doubled = #{inspect doubled}"
    IO.puts "7. Enumerable: Evens = #{inspect evens}"
    IO.puts "7. Enumerable: Sum = #{sum_enum}"
    IO.puts "7. Enumerable: has_three? = #{has_three?}"
    IO.puts "7. Enumerable: Squared Odds (comprehension) = #{inspect squared_odds}"
    IO.puts "7. Enumerable: Map from comprehension = #{inspect map_from_comp}"

    # --- 8. Streams ---
    infinite_stream = Stream.cycle([:a, :b])
    first_five = infinite_stream |> Stream.take(5) |> Enum.to_list()
    processed_stream = 1..1_000_000 |> Stream.map(&(&1 * 2)) |> Stream.filter(&(rem(&1, 10) == 0)) |> Stream.take(3) |> Enum.to_list()
    IO.puts "8. Streams: First 5 of cycled stream = #{inspect first_five}"
    IO.puts "8. Streams: Result of chained stream operations = #{inspect processed_stream}"

    # --- 9. Structs (Usage) ---
    user1 = %ComprehensiveElixirDemo.User{name: "Eve"}
    user2 = %ComprehensiveElixirDemo.User{name: "Frank", age: 40}
    # FIXED: Added underscore
    _user1_age = user1.age
    user1_older = %{user1 | age: user1.age + 1}
    IO.puts "9. Structs: User 1 = #{inspect user1}"
    IO.puts "9. Structs: User 1 Older = #{inspect user1_older}"
    IO.puts "9. Structs: User 2 Name = #{user2.name}"

    # --- 10. Protocols (Usage) ---
    list_size = Size.size([10, 20, 30])
    tuple_size_val = Size.size({:a, :b, :c})
    user_size = Size.size(%ComprehensiveElixirDemo.User{name: "Grace"})
    string_size = Size.size("Elixir")
    IO.puts "10. Protocols: Size of [10, 20, 30] = #{list_size}"
    IO.puts "10. Protocols: Size of {:a, :b, :c} = #{tuple_size_val}"
    IO.puts "10. Protocols: Size of User 'Grace' = #{user_size}"
    IO.puts "10. Protocols: Size of 'Elixir' = #{string_size}"

    # --- 11. Concurrency Basics (Processes) ---
    self_pid = self()
    IO.puts "11. Concurrency: Runner process PID = #{inspect self_pid}"
    spawned_pid = spawn(fn ->
      receive do
        {:ping, sender_pid} -> send(sender_pid, {:pong, self()})
        after 1000 -> IO.puts "11. Concurrency: Spawned process timed out."
      end
    end)
    send(spawned_pid, {:ping, self()})
    receive do
      {:pong, pid} -> IO.puts "11. Concurrency: Runner received pong from #{inspect pid}"
      after 2000 -> IO.puts "11. Concurrency: Runner timed out waiting for pong."
    end

    # --- 12. OTP Basics (GenServer Usage) ---
    case ComprehensiveElixirDemo.SimpleCounter.start_link(10) do
      {:ok, counter_pid} ->
        IO.puts "12. OTP (GenServer): Started counter with PID #{inspect counter_pid}"
        ComprehensiveElixirDemo.SimpleCounter.increment(5)
        ComprehensiveElixirDemo.SimpleCounter.decrement(2)
        Process.sleep(50)
        current_value = ComprehensiveElixirDemo.SimpleCounter.value()
        IO.puts "12. OTP (GenServer): Current counter value = #{current_value}"
      {:error, {:already_started, pid}} ->
         IO.puts "12. OTP (GenServer): Counter already started at #{inspect pid}. Interacting..."
         ComprehensiveElixirDemo.SimpleCounter.increment(1)
         Process.sleep(50)
         current_value = ComprehensiveElixirDemo.SimpleCounter.value()
         IO.puts "12. OTP (GenServer): Current counter value = #{current_value}"
      {:error, reason} ->
        IO.puts "12. OTP (GenServer): Failed to start counter: #{inspect reason}"
    end

    # --- 13. Metaprogramming Basics (Macro Usage) ---
    macro_test_var = 5
    custom_unless macro_test_var > 10 do
      IO.puts "13. Metaprogramming: Using custom 'custom_unless': Condition is false (5 !> 10)"
    else
      IO.puts "13. Metaprogramming: Using custom 'custom_unless': Condition is true (this shouldn't print)"
    end

    # --- 14. Sigils ---
    word_list = ~w(apple banana cherry)a
    char_list_sigil = ~c(sigil)
    regex_sigil = ~r/^\d{3}$/
    date_sigil = ~D[2024-01-15]
    naive_dt_sigil = ~N[2024-01-15 14:30:00]
    IO.puts "14. Sigils: Word atom list = #{inspect word_list}"
    IO.puts "14. Sigils: Char list = #{inspect char_list_sigil}"
    IO.puts "14. Sigils: Regex matches '123'? #{Regex.match?(regex_sigil, "123")}"
    IO.puts "14. Sigils: Date = #{inspect date_sigil}"
    IO.puts "14. Sigils: Naive DateTime = #{inspect naive_dt_sigil}"

    IO.puts "\n--- Comprehensive Elixir Demo Execution Finished ---"
  end # End def run

end # End defmodule ComprehensiveElixirDemo

# --- Script Execution Trigger ---
ComprehensiveElixirDemo.run()

IO.puts "\nScript execution finished."