// package declaration (optional if in default package)
package com.example.kotlinoverview

// Imports (used for specific features)
// import kotlinx.coroutines.* // Required for Coroutines example - COMMENTED OUT for basic CLI compilation
import java.io.IOException // Required for Exception Handling example
import kotlin.random.Random // Used in various examples

// === Top Level Type Aliases === (Moved here from main)
typealias Name = String
typealias Email = String

/**
 * Kotlin Comprehensive Overview File
 *
 * This file demonstrates various features of the Kotlin programming language.
 * It's intended as a quick reference and showcase, not an exhaustive tutorial.
 */

// === 1. Basic Syntax ===

// Top-level variables and functions are allowed
const val COMPILE_TIME_CONSTANT = "I am fixed at compile time" // Compile-time constant (primitive or String)

// `main` function: the entry point of the application
fun main() {
    println("--- Kotlin Language Overview ---")
    println(COMPILE_TIME_CONSTANT)

    // --- Variables ---
    // val: read-only (immutable reference, object itself might be mutable)
    val readOnlyInt: Int = 10
    val readOnlyString = "Hello" // Type inference (String)

    // var: mutable reference
    var mutableInt: Int = 20
    mutableInt += 5 // mutableInt is now 25

    println("\n--- Variables ---")
    println("Read-only val: $readOnlyInt, $readOnlyString") // String Templates
    println("Mutable var: $mutableInt")

    // --- Basic Types ---
    val myInt: Int = 100
    val myLong: Long = 100L
    val myDouble: Double = 3.14
    val myFloat: Float = 3.14f
    val myBoolean: Boolean = true
    val myChar: Char = 'K'
    val myString: String = "Kotlin"

    // --- Operators ---
    val sum = myInt + 50
    val condition = (sum > 100) && myBoolean
    println("\n--- Operators & Types ---")
    println("Sum: $sum, Condition: $condition")

    // === 2. Control Flow ===
    println("\n--- Control Flow ---")

    // --- If/Else Expression ---
    val resultIf = if (mutableInt > 20) {
        println("MutableInt is greater than 20")
        "Greater" // Last expression is the return value
    } else {
        println("MutableInt is not greater than 20")
        "Not Greater"
    }
    println("If result: $resultIf")

    // --- When Expression (like switch, but more powerful) ---
    val valueToCheck = 3
    val whenResult = when (valueToCheck) {
        1 -> "One"
        2 -> "Two"
        in 3..5 -> "Between 3 and 5" // Ranges
        is Int -> "It's an Integer (but not 1, 2, or 3-5)" // Type check
        else -> "Something else"
    }
    println("When result: $whenResult")

    // When without an argument (acts like chained if-else)
    val description = when {
        myString.startsWith("Kot") -> "Starts with Kot"
        myString.length > 10 -> "Long string"
        else -> "Default description"
    }
    println("When description: $description")

    // --- For Loop ---
    println("For loop (range):")
    for (i in 1..4) { // Inclusive range
        print("$i ")
    }
    println()

    println("For loop (step):")
    for (i in 6 downTo 0 step 2) { // Downward loop with step
        print("$i ")
    }
    println()

    val items = listOf("apple", "banana", "kiwi")
    println("For loop (collection):")
    for (item in items) {
        print("$item ")
    }
    println()

    println("For loop (indices):")
    for (index in items.indices) {
        print("Item at $index is ${items[index]} ")
    }
    println()

    // --- While Loop ---
    var i = 0
    print("While loop: ")
    while (i < 3) {
        print("${i++} ") // Prints 0 1 2
    }
    println()

    // --- Do-While Loop ---
    var j = 5
    print("Do-while loop: ")
    do {
        print("${j--} ") // Prints 5
    } while (j > 5) // Condition checked after first execution
    println()


    // === 3. Functions ===
    println("\n--- Functions ---")

    // --- Basic Function Call ---
    println("Basic function result: ${add(5, 3)}")

    // --- Named & Default Arguments ---
    greet("Alice") // Uses default message
    greet("Bob", "Howdy") // Overrides default message
    greet(message = "Good day", name = "Charlie") // Named arguments (order doesn't matter)

    // --- Extension Function Call ---
    val original = "kotlin is fun"
    println("Extension function: ${original.capitalizeWords()}")

    // --- Higher-Order Functions & Lambdas ---
    val numbers = listOf(1, 2, 3, 4, 5)
    val doubled = operateOnList(numbers) { x -> x * 2 } // Lambda syntax
    val tripled = operateOnList(numbers) { it * 3 } // 'it' for single parameter lambda
    println("Higher-Order (doubled): $doubled")
    println("Higher-Order (tripled): $tripled")

    // --- Infix Function Call ---
    val point = Point(1, 1)
    val movedPoint = point moveTo Point(2, 3) // Infix call
    println("Infix function: $movedPoint")

    // --- Tail Recursive Function Call ---
    println("Factorial (tailrec): ${factorial(5)}")


    // === 4. Null Safety ===
    println("\n--- Null Safety ---")
    var nullableString: String? = "Can be null"
    // println(nullableString.length) // Compile error: only safe (?.) or non-null asserted (!!) calls allowed

    // --- Safe Call (?.) ---
    println("Safe call: ${nullableString?.length}") // Prints length or null
    nullableString = null
    println("Safe call (null): ${nullableString?.length}") // Prints null

    // --- Elvis Operator (?:) ---
    val lengthOrDefault = nullableString?.length ?: -1 // If null, use -1
    println("Elvis operator: $lengthOrDefault")

    // --- Not-Null Assertion (!!) - Use with caution! ---
    var nonNullString = "Definitely not null"
    // nonNullString = null // If uncommented, the next line would crash
    try {
        println("Not-null assertion: ${nonNullString!!.length}")
        // If nullableString was null, this would throw NullPointerException:
        // println(nullableString!!.length)
    } catch (e: NullPointerException) {
        println("Caught NPE from !! operator")
    }

    // --- lateinit var --- (Initialized later, throws if accessed before init)
    setupLateinit()
    println("Lateinit var: $lateInitVar")
    // println(anotherLateInitVar) // Would throw UninitializedPropertyAccessException

    // --- lazy delegate --- (Initialized on first access)
    println("Lazy val (accessing first time): $lazyValue")
    println("Lazy val (accessing second time): $lazyValue") // Won't execute initializer again


    // === 5. Object-Oriented Programming (OOP) ===
    println("\n--- OOP ---")

    // --- Class Instantiation ---
    val myCar = Car("Toyota", "Camry", 2022)
    println("My car: ${myCar.displayInfo()}")
    myCar.startEngine()
    myCar.drive()

    val electricCar = ElectricCar("Tesla", "Model 3", 2023, 75.0)
    println("Electric car: ${electricCar.displayInfo()}, Battery: ${electricCar.batteryCapacity} kWh")
    electricCar.startEngine() // Overridden method
    electricCar.charge()

    // --- Data Class ---
    val user1 = User(1, "Alice", "alice@example.com")
    val user2 = User(1, "Alice", "alice@example.com")
    val user3 = User(2, "Bob", "bob@example.com")
    println("Data class user1: $user1") // toString() generated
    println("user1 == user2: ${user1 == user2}") // equals() generated
    println("user1 == user3: ${user1 == user3}")
    val user1Copy = user1.copy(name = "Alice Smith") // copy() generated
    println("Copied user: $user1Copy")
    val (id, name, _) = user1 // Destructuring declaration (ignore email)
    println("Destructured User: ID=$id, Name=$name")

    // --- Sealed Class ---
    processResult(Result.Success("Data loaded"))
    processResult(Result.Error(IOException("Network failed")))
    // val otherResult: Result = Result() // Error: Cannot instantiate abstract class
    // class AnotherResult : Result() {} // Error: Cannot inherit sealed class outside its module/file

    // --- Object (Singleton) ---
    Logger.log("This is a log message from the singleton Logger.")
    Logger.logLevel = Logger.Level.DEBUG
    Logger.log("This is a debug message.")

    // --- Companion Object ---
    val instance = MyClass.create() // Accessing companion object function like static method
    println(MyClass.COMPANION_CONSTANT) // Accessing companion object property


    // === 6. Functional Programming (Collections) ===
    println("\n--- Functional Programming (Collections) ---")
    val numberList = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

    val squaredNumbers = numberList.map { it * it }
    println("Squared: $squaredNumbers")

    val evenNumbers = numberList.filter { it % 2 == 0 }
    println("Even: $evenNumbers")

    val sumOfNumbers = numberList.reduce { acc, number -> acc + number }
    println("Sum: $sumOfNumbers")

    val firstEven = numberList.firstOrNull { it % 2 == 0 }
    println("First even: $firstEven")

    val anyGreaterThan5 = numberList.any { it > 5 }
    println("Any > 5: $anyGreaterThan5")

    val allEven = numberList.all { it % 2 == 0 }
    println("All even: $allEven")

    println("For each:")
    numberList.filter { it > 7 }.forEach { print("$it ") }
    println()


    // === 7. Generics ===
    println("\n--- Generics ---")
    val intBox = Box(123)
    val stringBox = Box("Hello Generics")
    println("Int box contains: ${intBox.content}")
    println("String box contains: ${stringBox.content}")
    // intBox.content = "abc" // Compile error: Type mismatch

    val firstItem = getFirst(listOf("a", "b", "c"))
    val firstNum = getFirst(listOf(1, 2, 3))
    println("Generic function results: $firstItem, $firstNum")


    /* // === SECTION 8 COMMENTED OUT FOR BASIC CLI COMPILATION ===
    // === 8. Coroutines (Asynchronous Programming) ===
    println("\n--- Coroutines ---")
    // Coroutines need a scope to run in. `runBlocking` blocks the main thread
    // until the coroutines inside it complete. Good for main functions/tests.
    // In Android/Servers, you'd use other scopes like `viewModelScope` or `GlobalScope` (carefully).
    runBlocking { // Start a blocking coroutine scope
        println("Coroutine context: $coroutineContext")

        // launch: Fire and forget
        val job1 = launch {
            delay(100L) // Non-blocking delay
            println("Coroutine 1 finished after delay.")
        }

        // async: Perform task asynchronously and return a result (Deferred)
        val deferredResult: Deferred<String> = async {
            delay(200L)
            println("Coroutine 2 calculating result...")
            "Result from Coroutine 2"
        }

        println("Launched coroutines...")
        val result = deferredResult.await() // Wait for the async result (non-blocking within coroutine)
        println("Async result: $result")

        job1.join() // Wait for job1 to complete (non-blocking within coroutine)
        println("All coroutines finished.")
    } // runBlocking ends here
    */ // === END OF COMMENTED OUT SECTION 8 ===


    // === 9. Exception Handling ===
    println("\n--- Exception Handling ---")
    try {
        val divisionResult = 10 / getZero() // Potential ArithmeticException
        println("Division result: $divisionResult") // This won't print if getZero() returns 0
    } catch (e: ArithmeticException) {
        println("Caught exception: ${e.message}")
    } catch (e: Exception) { // Catching broader exception type
        println("Caught generic exception: ${e.message}")
    } finally {
        println("This 'finally' block always executes.")
    }

    // Try can also be an expression
    val input = "abc"
    val parsedNumber: Int? = try {
        input.toInt()
    } catch (e: NumberFormatException) {
        null // Return null if parsing fails
    }
    println("Parsed number (try-expression): $parsedNumber")


    // === 10. Other Features ===
    println("\n--- Other Features ---")

    // --- Type Alias Usage ---
    // Type aliases 'Name' and 'Email' are now defined at the top level
    data class Employee(val name: Name, val email: Email) // Definition inside main is okay
    val emp = Employee("Jane Doe", "jane@work.com")
    println("Employee with type aliases: $emp")

    // Destructuring already shown with Data Classes

    println("\n--- End of Overview ---")
} // End of main function

// === Function Definitions ===

// --- Basic Function ---
fun add(a: Int, b: Int): Int { // Explicit return type
    return a + b
}

// --- Function with Default and Named Arguments ---
fun greet(name: String, message: String = "Hello") { // Default value for message
    println("$message, $name!")
}

// --- Extension Function ---
// Adds a new function `capitalizeWords` to the String class
fun String.capitalizeWords(): String {
    return this.split(" ").joinToString(" ") { it.replaceFirstChar { char -> char.uppercase() } }
}

// --- Higher-Order Function ---
// Takes a list and a function (lambda) as parameters
fun operateOnList(list: List<Int>, operation: (Int) -> Int): List<Int> {
    val result = mutableListOf<Int>()
    for (item in list) {
        result.add(operation(item)) // Apply the passed function
    }
    return result
}

// --- Infix Function ---
data class Point(val x: Int, val y: Int)
// Allows calling like `point1 moveTo point2`
infix fun Point.moveTo(other: Point): Point {
    return Point(this.x + other.x, this.y + other.y)
}

// --- Recursive and Tail Recursive Function ---
// Standard recursion (can cause StackOverflowError for large inputs)
// fun factorialRecursive(n: Long): Long {
//     return if (n <= 1) 1 else n * factorialRecursive(n - 1)
// }

// Tail recursive function (optimized by the compiler to avoid StackOverflowError)
tailrec fun factorial(n: Long, accumulator: Long = 1): Long {
    return if (n <= 1) accumulator else factorial(n - 1, n * accumulator)
}


// === Null Safety Helpers ===
lateinit var lateInitVar: String // Declared, but not yet initialized

// lateinit var anotherLateInitVar: String // If uncommented and never initialized, would cause error on access

fun setupLateinit() {
    // Check if already initialized (optional, good practice in some cases)
    if (!::lateInitVar.isInitialized) {
         lateInitVar = "Initialized!"
    }
}

val lazyValue: String by lazy {
    println("--- Initializing lazy value ---") // This will print only once
    "I am lazy and initialized!"
}


// === OOP Definitions ===

// --- Interface ---
interface Drivable {
    fun drive() // Abstract method (no implementation)
    fun stop() { // Default implementation
        println("Stopping the vehicle.")
    }
}

// --- Abstract Class ---
// Cannot be instantiated directly, can have abstract and non-abstract members
abstract class Vehicle(val make: String, val model: String) {
    abstract val year: Int // Abstract property (must be overridden)

    abstract fun startEngine() // Abstract method (must be overridden)

    open fun displayInfo(): String { // Open: can be overridden by subclasses
        return "$year $make $model"
    }
}

// --- Concrete Class inheriting from Abstract Class and implementing Interface ---
// `open` keyword allows this class to be subclassed further
open class Car(make: String, model: String, override val year: Int) : Vehicle(make, model), Drivable {

    // Secondary constructor (must delegate to primary constructor)
    constructor(make: String, model: String) : this(make, model, 2024) {
        println("Secondary constructor called for $make $model")
    }

    // Overriding abstract members
    override fun startEngine() {
        println("Car engine starting... Vroom!")
    }

    override fun drive() {
        println("Driving the car $make $model.")
    }

    // Overriding open function (optional)
    override fun displayInfo(): String {
        return "Car: ${super.displayInfo()}" // Call superclass implementation
    }

    // Visibility Modifiers:
    // public (default): visible everywhere
    // private: visible only inside this class
    // protected: visible inside this class and subclasses
    // internal: visible anywhere in the same module
    private fun internalCheck() {
        println("Performing internal car check.")
    }

    // Companion Object: Associated with the class, holds 'static'-like members
    companion object Factory {
        const val WHEELS = 4
        fun createDefaultCar(): Car {
            return Car("Generic", "Model", 2020)
        }
    }
}

// --- Inheritance ---
class ElectricCar(
    make: String,
    model: String,
    year: Int,
    val batteryCapacity: Double // Property specific to ElectricCar
) : Car(make, model, year) { // Inherits from Car

    override fun startEngine() { // Overriding an already overridden method
        println("Electric car starting silently... Whirr!")
    }

    fun charge() {
        println("Charging the electric car.")
    }

    // Cannot access private members of Car:
    // fun runInternalCheck() { internalCheck() } // Error: internalCheck is private in Car
}


// --- Data Class ---
// Automatically generates: equals(), hashCode(), toString(), copy(), componentN() functions
data class User(val id: Long, val name: String, val email: String?)


// --- Sealed Class ---
// Restricts class hierarchies. All direct subclasses must be declared in the same file/module.
// Often used for representing restricted states or results (like success/error).
sealed class Result<out T> { // `out` makes it covariant (needed for subtypes)
    data class Success<out T>(val data: T) : Result<T>()
    data class Error(val exception: Exception) : Result<Nothing>() // Nothing has no instances
    // object Loading : Result<Nothing>() // Can also have object subclasses
}

fun processResult(result: Result<String>) {
    when (result) {
        is Result.Success -> println("Success! Data: ${result.data}")
        is Result.Error -> println("Error! Exception: ${result.exception.message}")
        // If Loading was defined:
        // is Result.Loading -> println("Loading...")
    }
}


// --- Object (Singleton Pattern) ---
// A class with only one instance, created lazily on first access.
object Logger {
    enum class Level { INFO, DEBUG, WARN, ERROR }
    var logLevel: Level = Level.INFO

    fun log(message: String) {
        if (logLevel <= Level.INFO) { // Simple level check (using enum ordinal implicitly here, better explicit check sometimes)
             println("[${logLevel.name}] $message")
        } else if (logLevel == Level.DEBUG) {
            println("[${logLevel.name}] $message")
        }
        // Add WARN/ERROR if needed
    }
}

// --- Class with Companion Object ---
class MyClass private constructor() { // Private constructor
    companion object {
        const val COMPANION_CONSTANT = "Value from Companion"
        fun create(): MyClass {
            println("Creating MyClass instance via Companion Object")
            return MyClass()
        }
    }
}

// === Generics Definitions ===
// --- Generic Class ---
class Box<T>(var content: T) // T is a type parameter

// --- Generic Function ---
fun <T> getFirst(list: List<T>): T? { // Can work with List<String>, List<Int>, etc.
    return list.firstOrNull()
}


// === Exception Handling Helper ===
fun getZero(): Int {
    // Simulate a condition that might lead to an error
    if (Random.nextBoolean()) { // Randomly return 0
       print("(Attempting 10/0) ")
       return 0
    }
    print("(Attempting 10/1) ")
    return 1 // Or return 1
}