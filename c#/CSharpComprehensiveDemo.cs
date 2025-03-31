// CSharpComprehensiveDemo.cs

// -- 1. Basic Structure & Usings --
// 'using' directives import namespaces, making types within them accessible without full qualification.
using System; // Core .NET types (Console, String, Int32, Exception, etc.)
using System.Collections; // Non-generic collections (use generic preferred)
using System.Collections.Generic; // Generic collections (List<T>, Dictionary<TKey, TValue>, etc.)
using System.Linq; // LINQ extension methods (Querying collections)
using System.Threading.Tasks; // Asynchronous programming (Task, async, await)
using System.IO; // File Input/Output
using System.Text; // String manipulation (StringBuilder)

// Enable nullable reference types checking (a modern C# feature)
#nullable enable // Can be disable, enable, restore, safeonly

// 'namespace' organizes code and prevents naming conflicts.
namespace CSharpComprehensiveDemo
{
    // -- 2. Enums --
    // Enums define a set of named constants. By default, underlying type is int.
    public enum LogLevel
    {
        Trace, // = 0
        Debug, // = 1
        Info,  // = 2
        Warning,// = 3
        Error, // = 4
        Fatal  // = 5
    }

    // -- 3. Structs --
    // Structs are value types, typically used for small, immutable data structures.
    public struct Point(int x, int y) // Primary constructor (C# 12)
    {
        public int X { get; } = x; // Auto-implemented property with init accessor
        public int Y { get; } = y;

        // Instance method
        public double DistanceFromOrigin() => Math.Sqrt(X * X + Y * Y);

        // Override ToString for better representation
        public override string ToString() => $"({X}, {Y})";
    }

    // -- 4. Interfaces --
    // Interfaces define a contract (a set of methods, properties, events, indexers) that a class or struct must implement.
    public interface ILoggable
    {
        void Log(string message, LogLevel level = LogLevel.Info); // Method with default parameter value
    }

    public interface IMovable
    {
        int Speed { get; set; } // Property contract
        void Move(int deltaX, int deltaY); // Method contract
    }

    // -- 5. Delegates --
    // Delegates are type-safe function pointers. They define the signature of methods that can be referenced.
    public delegate void NotificationHandler(string message); // Delegate for methods taking string, returning void

    // -- 6. Classes (Object-Oriented Programming - OOP) --
    // Classes are reference types and form the basis of OOP.

    // Base Class (can be abstract if it shouldn't be instantiated directly)
    public abstract class Entity : ILoggable // Inherits from object implicitly, implements ILoggable
    {
        // -- Fields --
        // Private field (backing field for property)
        private string _id;
        protected static int _entityCount = 0; // Static field shared by all instances

        // -- Properties --
        // Public property with validation in the setter
        public string Id
        {
            get { return _id; } // Getter
            protected set // Setter (accessible only within this class and derived classes)
            {
                if (string.IsNullOrWhiteSpace(value))
                {
                    throw new ArgumentException("ID cannot be null or whitespace.");
                }
                _id = value;
            }
        }
        public DateTime CreationTime { get; private set; } // Auto-implemented property with private setter

        // -- Static Property --
        public static int EntityCount => _entityCount; // Expression-bodied property (read-only)

        // -- Constructors --
        // Default constructor (often implicit if no other constructors are defined)
        // protected Entity() { } // Make it protected if abstract

        // Parameterized constructor
        protected Entity(string id)
        {
            Log($"Creating Entity with ID: {id}", LogLevel.Debug); // Call implemented interface method
            Id = id; // Use the property setter for validation
            CreationTime = DateTime.UtcNow;
            _entityCount++; // Increment static counter
        }

        // -- Methods --
        // Abstract method - must be implemented by derived non-abstract classes
        public abstract void Describe();

        // Virtual method - can be overridden by derived classes
        public virtual void UpdateStatus(string status)
        {
            Log($"Entity {Id} status updated: {status}");
        }

        // Implementation of ILoggable interface method
        public void Log(string message, LogLevel level = LogLevel.Info)
        {
            // Basic logging implementation
            Console.WriteLine($"[{level} - {DateTime.UtcNow:HH:mm:ss}] {message}");
        }

        // -- Static Method --
        public static void PrintTotalEntityCount()
        {
            Console.WriteLine($"Total entities created: {EntityCount}");
        }

        // -- Destructor / Finalizer (Use with caution - IDisposable is preferred for resource cleanup) --
        // ~Entity()
        // {
        //     // Cleanup unmanaged resources here (rarely needed in pure C#)
        //     Console.WriteLine($"Finalizing Entity {Id}");
        //     _entityCount--; // Be careful with static members in finalizers
        // }
    }

    // Derived Class
    public class Vehicle : Entity, IMovable // Inherits from Entity, implements IMovable
    {
        // -- Fields --
        private int _speed;

        // -- Properties --
        public string Model { get; set; } // Auto-implemented property

        // Implementation of IMovable interface property
        public int Speed
        {
            get => _speed;
            set
            {
                if (value < 0) throw new ArgumentOutOfRangeException(nameof(value), "Speed cannot be negative.");
                _speed = value;
            }
        }

        // -- Constructor --
        // Calls the base class constructor using 'base()'
        public Vehicle(string id, string model) : base(id)
        {
            Model = model;
            Speed = 0;
            Log($"Vehicle {Model} ({Id}) created.");
        }

        // -- Methods --
        // Implementation of abstract method from base class
        public override void Describe()
        {
            Console.WriteLine($"This is a Vehicle. Model: {Model}, ID: {Id}, Speed: {Speed}");
        }

        // Overriding a virtual method from base class
        public override void UpdateStatus(string status)
        {
            base.UpdateStatus(status); // Call the base class implementation
            Console.WriteLine($"Vehicle-specific status update logic for {Model}.");
        }

        // Implementation of IMovable interface method
        public void Move(int deltaX, int deltaY)
        {
            if (Speed <= 0)
            {
                Log($"Vehicle {Model} cannot move, speed is {Speed}.", LogLevel.Warning);
                return;
            }
            Console.WriteLine($"Vehicle {Model} is moving by ({deltaX}, {deltaY}) at speed {Speed}.");
            // In a real scenario, update position here
        }
    }

    // Sealed class - cannot be inherited from
    public sealed class Car : Vehicle
    {
        public int NumberOfDoors { get; }

        public Car(string id, string model, int doors) : base(id, model)
        {
            NumberOfDoors = doors;
        }

        // Override Describe again
        public override void Describe()
        {
            // Note: We don't call base.Describe() here, replacing it entirely
            Console.WriteLine($"This is a Car. Model: {Model}, ID: {Id}, Speed: {Speed}, Doors: {NumberOfDoors}");
        }

        // New method specific to Car
        public void Honk()
        {
            Console.WriteLine($"{Model} goes: Beep beep!");
        }
    }

    // Static class - cannot be instantiated, contains only static members
    public static class Utilities
    {
        public const double Pi = 3.14159; // Compile-time constant

        public static readonly string AppVersion = "1.0"; // Runtime constant (initialized once)

        public static int Add(int a, int b) => a + b; // Expression-bodied method

        // Extension Method: Extends the string class without modifying it
        public static string Reverse(this string input)
        {
            char[] chars = input.ToCharArray();
            Array.Reverse(chars);
            return new string(chars);
        }
    }

    // -- 7. Generics --
    // Generic class - works with any type T
    public class Repository<T> where T : Entity // Type constraint: T must be or derive from Entity
    {
        private readonly List<T> _items = new List<T>();

        public void Add(T item)
        {
            _items.Add(item);
            item.Log($"Added {typeof(T).Name} with ID {item.Id} to repository.");
        }

        public T? FindById(string id) // Return type is nullable
        {
            // Using LINQ method syntax
            return _items.FirstOrDefault(item => item.Id.Equals(id, StringComparison.OrdinalIgnoreCase));
        }

        public IEnumerable<T> GetAll() => _items;
    }

    // -- 8. Events --
    public class EventPublisher
    {
        // Define the event based on the delegate type
        public event NotificationHandler? SomethingHappened; // Nullable event

        public void DoSomething(string data)
        {
            Console.WriteLine($"Publisher doing something with: {data}");
            // Raise the event if there are subscribers
            OnSomethingHappened($"Data processed: {data}");
        }

        // Protected virtual method to raise the event (standard pattern)
        protected virtual void OnSomethingHappened(string message)
        {
            // Check if there are any subscribers before raising
            // Use the null-conditional operator ?.Invoke() for thread safety in simple cases
            SomethingHappened?.Invoke(message);
        }
    }

    // -- 9. Records (C# 9+) --
    // Records are reference types (or structs) primarily for encapsulating data.
    // They provide value-based equality and immutability by default.
    public record Person(string FirstName, string LastName, int Age); // Concise declaration

    // Can also be declared like classes with explicit properties and methods
    public record struct Transaction(string Ticker, decimal Amount, DateTime Timestamp); // Record struct (value type)


    // -- Main Program Class --
    public class Program
    {
        // -- Asynchronous Method --
        // Marked with 'async', returns Task or Task<T>
        static async Task<string> FetchDataFromServerAsync(string url)
        {
            Console.WriteLine($"Starting data fetch from {url}...");
            // Simulate network delay without blocking the thread
            await Task.Delay(1500); // Non-blocking wait
            Console.WriteLine("...Data fetch complete.");
            return $"<html>Data from {url}</html>";
        }

        // -- Recursive Method --
        static long Factorial(int n)
        {
            // Base case
            if (n < 0) throw new ArgumentException("Factorial is not defined for negative numbers.");
            if (n == 0) return 1;
            // Recursive step
            return n * Factorial(n - 1);
        }

        // -- Method with ref and out parameters --
        static void ModifyValues(ref int referenceValue, out int outputValue, in int inputValue)
        {
            Console.WriteLine($"Inside ModifyValues - Initial ref: {referenceValue}, Initial in: {inputValue}");
            referenceValue *= 2; // Modifies the original variable passed as 'ref'
            outputValue = referenceValue + inputValue; // Must assign a value to 'out' parameter before exiting
            // inputValue = 10; // Cannot assign to 'in' parameter
            Console.WriteLine($"Inside ModifyValues - Final ref: {referenceValue}, Assigned out: {outputValue}");
        }

        // -- Method using params keyword --
        static int SumAll(params int[] numbers)
        {
            return numbers.Sum(); // Using LINQ Sum()
        }

        // -- Main Entry Point --
        // Can be 'async Task' to allow 'await' at the top level
        static async Task Main(string[] args) // string[] args holds command-line arguments
        {
            Console.WriteLine("===== C# Comprehensive Demo Start =====");

            // -- 10. Variables, Constants, Data Types --
            Console.WriteLine("\n--- Variables, Constants, Data Types ---");
            const double Gravity = 9.81; // Compile-time constant
            int age = 30;
            double price = 19.99;
            bool isActive = true;
            char initial = 'J';
            string name = "Alice"; // string is a reference type but often behaves like a value type
            var inferredType = "This is a string"; // Type inference with 'var'
            int? nullableInt = null; // Nullable value type
            string? nullableString = null; // Nullable reference type (if #nullable enable)

            Console.WriteLine($"Name: {name}, Age: {age}, Active: {isActive}, Price: ${price}, Initial: {initial}");
            Console.WriteLine($"Gravity: {Gravity}, Inferred: {inferredType}");
            Console.WriteLine($"Nullable Int: {nullableInt?.ToString() ?? "Null"}"); // Null-coalescing operator ??
            nullableInt = 10;
            Console.WriteLine($"Nullable Int now: {nullableInt}"); // Has value
            nullableString = "Hello";
            Console.WriteLine($"Nullable String: {nullableString ?? "Was Null"}");

            // -- 11. Operators --
            Console.WriteLine("\n--- Operators ---");
            int a = 10, b = 3;
            Console.WriteLine($"Arithmetic: {a} + {b} = {a + b}, {a} / {b} = {a / b} (int division), {a} % {b} = {a % b}");
            Console.WriteLine($"Comparison: {a} > {b} is {a > b}");
            Console.WriteLine($"Logical: ({a} > 0) && ({b} > 0) is {(a > 0) && (b > 0)}");
            int c = 5;
            c += 3; // c = c + 3; => c is 8
            Console.WriteLine($"Assignment: c += 3 => {c}");
            string result = (c > 5) ? "Greater than 5" : "5 or less"; // Ternary operator
            Console.WriteLine($"Ternary: {result}");
            string? maybeNull = null;
            string definitelyNotNull = maybeNull ?? "Default Value"; // Null-coalescing
            Console.WriteLine($"Null Coalescing (??): {definitelyNotNull}");
            maybeNull ??= "Assigned if null"; // Null-coalescing assignment
            Console.WriteLine($"Null Coalescing Assignment (??=): {maybeNull}");

            // -- 12. Control Flow Statements --
            Console.WriteLine("\n--- Control Flow ---");
            // If-Else If-Else
            if (age < 18) Console.WriteLine("Minor");
            else if (age >= 18 && age < 65) Console.WriteLine("Adult");
            else Console.WriteLine("Senior");

            // Switch Statement (Classic)
            LogLevel currentLevel = LogLevel.Warning;
            switch (currentLevel)
            {
                case LogLevel.Trace:
                case LogLevel.Debug:
                    Console.WriteLine("Detailed logging.");
                    break; // Required unless falling through explicitly (goto case)
                case LogLevel.Info:
                    Console.WriteLine("Informational message.");
                    break;
                case LogLevel.Warning:
                    Console.WriteLine("Potential issue detected.");
                    break;
                case LogLevel.Error:
                case LogLevel.Fatal:
                    Console.WriteLine("Serious error!");
                    break;
                default: // Optional default case
                    Console.WriteLine("Unknown log level.");
                    break;
            }

            // Switch Expression (C# 8+)
            string levelDescription = currentLevel switch
            {
                LogLevel.Trace or LogLevel.Debug => "Detailed logging.", // Combine cases
                LogLevel.Info => "Informational message.",
                LogLevel.Warning => "Potential issue detected.",
                _ => "Serious error or unknown." // _ is the discard pattern (default)
            };
            Console.WriteLine($"Switch Expression Result: {levelDescription}");

            // For Loop
            Console.Write("For Loop: ");
            for (int i = 0; i < 5; i++)
            {
                Console.Write($"{i} ");
                if (i == 3) continue; // Skip rest of iteration
                // if (i == 4) break; // Exit loop early
            }
            Console.WriteLine();

            // While Loop
            Console.Write("While Loop: ");
            int counter = 0;
            while (counter < 3)
            {
                Console.Write($"{counter} ");
                counter++;
            }
            Console.WriteLine();

            // Do-While Loop (executes at least once)
            Console.Write("Do-While Loop: ");
            int doCounter = 5;
            do
            {
                Console.Write($"{doCounter} "); // Will print 5
                doCounter++;
            } while (doCounter < 3); // Condition checked after first iteration
            Console.WriteLine();

            // Foreach Loop (for collections)
            Console.Write("Foreach Loop (Array): ");
            int[] numbers = { 1, 2, 3, 4, 5 };
            foreach (int number in numbers)
            {
                Console.Write($"{number} ");
            }
            Console.WriteLine();

            // -- 13. Methods, Recursion, Ref/Out/Params/In --
            Console.WriteLine("\n--- Methods ---");
            Console.WriteLine($"Utilities.Add(5, 3): {Utilities.Add(5, 3)}");
            Console.WriteLine($"Factorial(5): {Factorial(5)}");

            int refVal = 10;
            int outVal; // Doesn't need initialization
            int inVal = 5;
            ModifyValues(ref refVal, out outVal, in inVal);
            Console.WriteLine($"After ModifyValues - refVal: {refVal}, outVal: {outVal}");

            Console.WriteLine($"SumAll(1, 2, 3): {SumAll(1, 2, 3)}");
            Console.WriteLine($"SumAll(10, 20, 30, 40, 50): {SumAll(10, 20, 30, 40, 50)}");


            // -- 14. OOP in Action (Classes, Interfaces, Inheritance, Polymorphism) --
            Console.WriteLine("\n--- OOP In Action ---");
            // Cannot create instance of abstract class: Entity e = new Entity("E1");
            Car myCar = new Car("C123", "Tesla Model 3", 4);
            Vehicle myTruck = new Vehicle("T456", "Ford F-150"); // Vehicle is concrete

            myCar.Speed = 60;
            myTruck.Speed = 50;

            myCar.Describe(); // Calls Car's override
            myTruck.Describe(); // Calls Vehicle's override

            // Polymorphism: Using a base class reference for derived objects
            List<Entity> entities = new List<Entity> { myCar, myTruck };
            Console.WriteLine("\nPolymorphism (Describing entities):");
            foreach (Entity entity in entities)
            {
                entity.Describe(); // Calls the appropriate override based on actual object type
                entity.UpdateStatus("Operational");

                // Type Checking and Casting
                if (entity is Car specificCar) // Pattern matching (C# 7+)
                {
                    specificCar.Honk();
                    Console.WriteLine($"It's a car with {specificCar.NumberOfDoors} doors.");
                }
                else if (entity is Vehicle v) // 'is' check
                {
                    // Can safely cast now
                    // Vehicle castedVehicle = (Vehicle)entity; // Older way
                    Console.WriteLine($"It's a generic vehicle: {v.Model}.");
                }
            }

            // Using interface references
            Console.WriteLine("\nUsing Interfaces:");
            IMovable mover = myCar; // Assign Car instance to IMovable variable
            mover.Move(10, 5);
            // mover.Honk(); // Error: Honk is not part of IMovable interface

            ILoggable logger = myTruck;
            logger.Log("Truck is ready.", LogLevel.Info);

            Entity.PrintTotalEntityCount(); // Accessing static member

            // -- 15. Structs and Enums --
            Console.WriteLine("\n--- Structs and Enums ---");
            Point p1 = new Point(3, 4); // Using primary constructor
            Point p2 = p1; // Value copy for structs
            // p2.X = 10; // Error if properties have init or private set
            Point p3 = new Point(10, 4);
            Console.WriteLine($"Point p1: {p1}, Distance from origin: {p1.DistanceFromOrigin()}");
            Console.WriteLine($"Point p3: {p3}, Are p1 and p3 equal? {p1.Equals(p3)}"); // Default Equals compares fields

            LogLevel currentLog = LogLevel.Error;
            Console.WriteLine($"Current Log Level: {currentLog} (Value: {(int)currentLog})");

            // -- 16. Arrays and Collections --
            Console.WriteLine("\n--- Arrays and Collections ---");
            // Single-dimensional array
            string[] names = { "Alice", "Bob", "Charlie" };
            names[1] = "Barbara"; // Modify element
            Console.WriteLine($"Names: {string.Join(", ", names)}");

            // Multi-dimensional array (rectangular)
            int[,] matrix = new int[2, 3] { { 1, 2, 3 }, { 4, 5, 6 } };
            Console.WriteLine($"Matrix element [1, 1]: {matrix[1, 1]}"); // Access element

            // Jagged array (array of arrays)
            int[][] jaggedArray = new int[3][];
            jaggedArray[0] = new int[] { 1, 2 };
            jaggedArray[1] = new int[] { 3, 4, 5 };
            jaggedArray[2] = new int[] { 6 };
            Console.WriteLine($"Jagged array element [1][2]: {jaggedArray[1][2]}");

            // List<T> (Generic List)
            List<string> cities = new List<string> { "New York", "London" };
            cities.Add("Tokyo");
            cities.Remove("London");
            Console.WriteLine($"Cities: {string.Join(", ", cities)}, Count: {cities.Count}");

            // Dictionary<TKey, TValue> (Generic Dictionary)
            Dictionary<string, int> cityPopulations = new Dictionary<string, int>
            {
                { "New York", 8400000 },
                ["London"] = 8900000 // Indexer syntax for adding/updating
            };
            cityPopulations.Add("Tokyo", 37000000);
            if (cityPopulations.TryGetValue("London", out int londonPop))
            {
                Console.WriteLine($"London Population: {londonPop:N0}"); // Format number
            }
            Console.WriteLine("City Populations:");
            foreach (KeyValuePair<string, int> kvp in cityPopulations)
            {
                Console.WriteLine($"- {kvp.Key}: {kvp.Value:N0}");
            }

            // -- 17. Exception Handling --
            Console.WriteLine("\n--- Exception Handling ---");
            try
            {
                int zero = 0;
                // Console.WriteLine(10 / zero); // This would throw DivideByZeroException

                // Throwing a custom exception or standard one
                if (DateTime.Now.DayOfWeek == DayOfWeek.Monday)
                {
                    // Generally avoid throwing Exception directly, use more specific types
                    // throw new Exception("Mondays are tough!");
                }

                // Accessing array out of bounds
                // Console.WriteLine(numbers[10]); // Throws IndexOutOfRangeException
            }
            catch (DivideByZeroException ex)
            {
                Console.WriteLine($"Caught specific exception: {ex.Message}");
            }
            catch (IndexOutOfRangeException ex)
            {
                Console.WriteLine($"Caught another specific exception: {ex.Message}");
            }
            catch (Exception ex) // Catch any other exception (general handler)
            {
                Console.WriteLine($"Caught general exception: {ex.GetType().Name} - {ex.Message}");
            }
            finally // This block always executes, regardless of exceptions
            {
                Console.WriteLine("Finally block executed (for cleanup).");
            }

            // Using statement for IDisposable resources (ensures Dispose is called)
            Console.WriteLine("\n--- Using Statement (IDisposable) ---");
            try
            {
                string tempFilePath = Path.GetTempFileName();
                // StreamWriter implements IDisposable
                using (StreamWriter writer = new StreamWriter(tempFilePath))
                {
                    writer.WriteLine("Hello from C# Demo!");
                    Console.WriteLine($"Wrote to temporary file: {tempFilePath}");
                    // No need to call writer.Close() or writer.Dispose() explicitly
                } // Dispose() is called automatically here, even if exceptions occur inside

                using (StreamReader reader = new StreamReader(tempFilePath))
                {
                    string content = reader.ReadToEnd();
                    Console.WriteLine($"Read back from file: {content.Trim()}");
                }

                File.Delete(tempFilePath); // Clean up the temp file
                Console.WriteLine("Temporary file deleted.");
            }
            catch(IOException ioEx)
            {
                Console.WriteLine($"File I/O Error: {ioEx.Message}");
            }


            // -- 18. LINQ (Language Integrated Query) --
            Console.WriteLine("\n--- LINQ ---");
            List<int> data = new List<int> { 5, 1, 8, 3, 9, 4, 7, 2, 6, 0 };

            // Method Syntax
            var evenNumbers = data.Where(n => n % 2 == 0) // Filter
                                  .OrderBy(n => n)       // Sort
                                  .Select(n => n * n);   // Project (transform)
            Console.WriteLine($"Squared Even Numbers (Method Syntax): {string.Join(", ", evenNumbers)}");

            // Query Syntax
            var oddNumbersGreaterThan3 = from n in data
                                         where n % 2 != 0 && n > 3
                                         orderby n descending
                                         select $"Odd > 3: {n}";
            Console.WriteLine($"Odd Numbers > 3 (Query Syntax):");
            foreach (var s in oddNumbersGreaterThan3) { Console.WriteLine($"- {s}"); }

            // LINQ with Objects
            var vehicles = entities.OfType<Vehicle>(); // Filter by type
            var fastModels = from v in vehicles
                             where v.Speed > 55
                             select v.Model;
            Console.WriteLine($"Fast Vehicle Models: {string.Join(", ", fastModels)}");
            double averageSpeed = vehicles.Average(v => v.Speed);
            Console.WriteLine($"Average Vehicle Speed: {averageSpeed:F2}");

            // -- 19. Generics in Action --
            Console.WriteLine("\n--- Generics in Action ---");
            Repository<Vehicle> vehicleRepo = new Repository<Vehicle>();
            vehicleRepo.Add(myTruck);
            // vehicleRepo.Add(myCar); // This works because Car derives from Vehicle (which derives from Entity)
            // Repository<string> stringRepo; // Error: string does not satisfy constraint 'where T : Entity'

            Vehicle? foundTruck = vehicleRepo.FindById("T456");
            foundTruck?.Describe(); // Use null-conditional operator ?.


            // -- 20. Delegates and Events in Action --
            Console.WriteLine("\n--- Delegates and Events ---");
            EventPublisher publisher = new EventPublisher();

            // Subscribe to the event using different methods
            // Method Group Conversion
            publisher.SomethingHappened += HandleNotification;
            // Lambda Expression
            publisher.SomethingHappened += (msg) => Console.WriteLine($"Subscriber 2 received (Lambda): {msg}");

            // Raise the event
            publisher.DoSomething("Initial Data");
            publisher.DoSomething("More Data");

            // Unsubscribe one handler
            publisher.SomethingHappened -= HandleNotification;
            Console.WriteLine("\nUnsubscribed HandleNotification.");
            publisher.DoSomething("Final Data");


            // -- 21. Asynchronous Programming (Async/Await) --
            Console.WriteLine("\n--- Async/Await ---");
            try
            {
                // Call the async method and wait for its result without blocking
                string webContent = await FetchDataFromServerAsync("http://example.com");
                Console.WriteLine($"Received content (simulated): {webContent.Substring(0, 20)}...");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Async operation failed: {ex.Message}");
            }


            // -- 22. Records and Pattern Matching --
            Console.WriteLine("\n--- Records and Pattern Matching ---");
            Person person1 = new Person("John", "Doe", 40);
            Person person2 = new Person("John", "Doe", 40);
            Person person3 = new Person("Jane", "Doe", 35);

            Console.WriteLine($"Person 1: {person1}"); // Nice ToString() output by default
            Console.WriteLine($"Person 1 == Person 2: {person1 == person2}"); // Value-based equality
            Console.WriteLine($"Person 1 == Person 3: {person1 == person3}");

            // With-expressions for non-destructive mutation
            Person olderPerson1 = person1 with { Age = 41 };
            Console.WriteLine($"Older Person 1: {olderPerson1}");
            Console.WriteLine($"Original Person 1 still: {person1}");

            Transaction tx = new("MSFT", 150.75m, DateTime.UtcNow);
            Console.WriteLine($"Transaction: {tx}");

            // Property Pattern Matching
            object obj = person1;
            if (obj is Person { FirstName: "John", Age: > 30 })
            {
                Console.WriteLine("Found a John Doe older than 30 using property pattern matching.");
            }

            // -- 23. Tuples --
            Console.WriteLine("\n--- Tuples ---");
            // ValueTuple (lightweight, mutable struct)
            (string Name, int Score) player = ("Alex", 100);
            Console.WriteLine($"Player: {player.Name}, Score: {player.Score}");
            player.Score += 50;
            Console.WriteLine($"Player after score update: {player}");

            var resultTuple = GetMinMax(numbers);
            Console.WriteLine($"Min/Max of numbers: Min={resultTuple.Min}, Max={resultTuple.Max}");

            // -- 24. Extension Methods --
            Console.WriteLine("\n--- Extension Methods ---");
            string original = "Hello World";
            string reversed = original.Reverse(); // Calling the extension method
            Console.WriteLine($"Original: '{original}', Reversed: '{reversed}'");

            Console.WriteLine("\n===== C# Comprehensive Demo End =====");

            // Keep console open in debug mode
            // Console.ReadKey(); // Optional: uncomment if running outside an IDE that holds the window open
        }

        // -- Helper Methods used in Main --
        static void HandleNotification(string message)
        {
            Console.WriteLine($"Subscriber 1 received (Method): {message}");
        }

        // Method returning a tuple
        static (int Min, int Max) GetMinMax(IEnumerable<int> values)
        {
            if (!values.Any())
            {
                throw new InvalidOperationException("Cannot get min/max of empty collection.");
            }
            return (values.Min(), values.Max()); // Use LINQ Min/Max
        }
    }
}

// -- Notes --
// - This file covers many core C# features but is not exhaustive.
// - Advanced topics like Reflection, Attributes in depth, Unsafe code, Interop,
//   advanced LINQ, advanced async patterns (ValueTask, IAsyncEnumerable), ASP.NET Core,
//   EF Core, UI frameworks (WPF, WinForms, MAUI), etc., are beyond the scope of a single file demo.
// - Error handling is basic; real applications require more robust strategies.
// - Concurrency and multi-threading (Thread, Monitor, lock, SemaphoreSlim, etc.) are not explicitly shown but Task implicitly uses the thread pool.
// - Newer C# features (like primary constructors, raw string literals, list patterns, etc.) are included where appropriate.
