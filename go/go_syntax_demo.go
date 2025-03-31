// comprehensive_go_syntax_demo.go

// Package declaration: Every Go program starts with a package declaration.
// `package main` defines an executable program (rather than a library).
package main

// Import statement: Imports packages to use their exported functions, types, etc.
// Standard library packages are common.
import (
	"errors" // For creating custom errors
	"fmt"    // For formatted I/O (like printing)
	"math"   // For basic math functions
	"runtime" // To get information about the Go runtime (e.g., OS)
	"strconv" // For string conversions
	"sync"    // For synchronization primitives (like WaitGroup)
	"time"    // For time-related functions
)

// --- Constants ---
// Constants are declared using `const`. They can be typed or untyped.
const Pi float64 = 3.14159 // Typed constant
const Greeting = "Hello"   // Untyped string constant (type inferred where used)
const (
	// iota is a special identifier used in const declarations to simplify definitions
	// of incrementing numbers. It starts at 0 for each const block.
	C0 = iota // C0 = 0
	C1 = iota // C1 = 1
	C2 = iota // C2 = 2
)
const (
	_         = iota             // Skip 0
	KB uint64 = 1 << (10 * iota) // 1 << (10*1) = 1024 (Kilobyte)
	MB uint64 = 1 << (10 * iota) // 1 << (10*2) = 1048576 (Megabyte)
	GB uint64 = 1 << (10 * iota) // 1 << (10*3) = 1073741824 (Gigabyte)
)

// --- Variables ---
// Variables are declared using `var`. Type comes *after* the variable name.
var globalVariable int = 100 // Variable with package scope

// --- Structs (User-defined Types) ---
// Structs are collections of named fields. They are used to group data together.
type Person struct {
	FirstName string
	LastName  string
	Age       int
}

// Structs can be embedded (composition, often used for pseudo-inheritance).
type Employee struct {
	Person         // Embedded struct (fields FirstName, LastName, Age are promoted)
	EmployeeID int
	Department string
}

// --- Interfaces ---
// Interfaces define a set of method signatures. A type implements an interface
// by implementing all methods defined in the interface. Implementation is implicit.
type Shaper interface {
	Area() float64
	Perimeter() float64
}

// Another interface
type Stringer interface {
	String() string
}

// --- Struct implementing interfaces ---
type Rectangle struct {
	Width, Height float64
}

// Method implementing Shaper.Area for Rectangle (Value Receiver)
// Methods are functions associated with a type.
func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

// Method implementing Shaper.Perimeter for Rectangle (Value Receiver)
func (r Rectangle) Perimeter() float64 {
	return 2*r.Width + 2*r.Height
}

// Method implementing Stringer for Rectangle (Value Receiver)
func (r Rectangle) String() string {
	return fmt.Sprintf("Rectangle{Width: %.2f, Height: %.2f}", r.Width, r.Height)
}

type Circle struct {
	Radius float64
}

// Method implementing Shaper.Area for Circle (Value Receiver)
func (c Circle) Area() float64 {
	return math.Pi * c.Radius * c.Radius
}

// Method implementing Shaper.Perimeter for Circle (Value Receiver)
func (c Circle) Perimeter() float64 {
	return 2 * math.Pi * c.Radius
}

// --- Functions ---
// Functions are declared using `func`. Parameters list types after names.
// Go supports multiple return values.
func addAndSubtract(a int, b int) (int, int) {
	return a + b, a - b
}

// Named return values: Return values can be named in the signature.
// A bare `return` statement will return the current values of these named variables.
func divide(dividend, divisor float64) (quotient float64, err error) {
	if divisor == 0.0 {
		// Idiomatic error handling: return zero value for quotient and an error.
		err = errors.New("division by zero")
		return // Returns the current values of quotient (0.0) and err
	}
	quotient = dividend / divisor
	// err is nil by default
	return // Returns calculated quotient and nil error
}

// Variadic functions: Accept a variable number of arguments of the same type.
func sumNumbers(numbers ...int) int {
	total := 0
	// `numbers` here is a slice of int ([]int)
	for _, num := range numbers {
		total += num
	}
	return total
}

// --- Recursion ---
// A function calling itself.
func factorial(n uint) uint {
	if n == 0 {
		return 1 // Base case
	}
	return n * factorial(n-1) // Recursive step
}

// --- Pointers ---
// Go has pointers. A pointer holds the memory address of a variable.
// `&` operator generates a pointer to its operand.
// `*` operator dereferences a pointer (accesses the value pointed to).
func increment(val *int) { // Function accepts a pointer to an int
	if val == nil {
		return // Important to check for nil pointers
	}
	*val++ // Increment the value at the memory address `val` points to
}

// --- Methods with Pointer Receivers ---
// Methods can also have pointer receivers. This allows the method to modify
// the original value of the struct instance. Often preferred for efficiency
// (avoids copying large structs) and required for modification.
type Counter struct {
	count int
}

func (c *Counter) Increment() { // Pointer receiver *Counter
	if c == nil { // Good practice to check for nil receiver
		fmt.Println("Cannot increment nil Counter")
		return
	}
	c.count++
}

func (c *Counter) Value() int { // Value receiver Counter (can be called on pointer too)
	if c == nil {
		fmt.Println("Cannot get value from nil Counter")
		return 0 // Return zero value
	}
	return c.count
}

// --- Main Function ---
// The entry point of the executable program.
func main() {
	fmt.Println("--- Go Syntax and Concepts Demonstration ---")
	fmt.Println(Greeting, "Go Developer!") // Using constant

	// --- Basic Variable Declaration and Initialization ---
	var i int // Declared, initialized to zero value (0 for int)
	var f float64 = 3.14
	var s string = "Go"
	var b bool = true
	fmt.Printf("Variables: i=%d, f=%.2f, s=%s, b=%t\n", i, f, s, b)

	// Short variable declaration `:=` (infers type, only inside functions)
	shortVar := "I'm short declared"
	inferredInt := 42
	fmt.Println("Short Var:", shortVar, "Inferred Int:", inferredInt)
	fmt.Println("Global Var:", globalVariable)
	fmt.Println("KB constant:", KB)

	// --- Control Flow ---
	// If/Else If/Else
	score := 75
	if score >= 90 {
		fmt.Println("Grade: A")
	} else if score >= 80 {
		fmt.Println("Grade: B")
	} else {
		fmt.Println("Grade: C or lower")
	}

	// If with a short statement (variable `num` is scoped to the if/else block)
	if num := 9; num < 0 {
		fmt.Println(num, "is negative")
	} else if num < 10 {
		fmt.Println(num, "has 1 digit")
	} else {
		fmt.Println(num, "has multiple digits")
	}
	// fmt.Println(num) // Error: num is not defined here

	// Switch statement
	os := runtime.GOOS
	fmt.Print("Go runs on ")
	switch os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd, plan9, windows...
		fmt.Printf("%s.\n", os)
	}

	// Switch without an expression (cleaner way to write long if/else chains)
	t := time.Now()
	switch {
	case t.Hour() < 12:
		fmt.Println("Good morning!")
	case t.Hour() < 17:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}

	// --- Loops ---
	// Go has only one looping construct: `for`

	// 1. Standard for loop (init; condition; post)
	fmt.Println("Standard for loop:")
	sum := 0
	for i := 0; i < 5; i++ {
		sum += i
	}
	fmt.Println("Sum (0-4):", sum)

	// 2. While loop equivalent (condition only)
	fmt.Println("While equivalent loop:")
	n := 1
	for n < 5 {
		n *= 2
	}
	fmt.Println("n after doubling:", n)

	// 3. Infinite loop (no condition) with break
	fmt.Println("Infinite loop with break:")
	counter := 0
	for {
		fmt.Println("Loop iteration", counter)
		if counter >= 2 {
			break // Exit the loop
		}
		counter++
	}

	// --- Data Structures ---
	// Arrays (fixed size)
	var arr [3]int // Array of 3 integers, initialized to 0
	arr[0] = 1
	arr[1] = 2
	fmt.Println("Array:", arr, "Length:", len(arr))
	primes := [5]int{2, 3, 5, 7, 11} // Array literal
	fmt.Println("Primes array:", primes)

	// Slices (dynamic size, backed by an array)
	slice := []int{10, 20, 30, 40, 50} // Slice literal
	fmt.Println("Slice:", slice, "Length:", len(slice), "Capacity:", cap(slice))

	// Slicing a slice (or array) creates a new slice header pointing to the same underlying array
	subSlice := slice[1:3] // Elements from index 1 up to (but not including) 3 -> [20, 30]
	fmt.Println("Sub-slice:", subSlice)
	subSlice[0] = 99 // Modifies the original slice's underlying array!
	fmt.Println("Original slice after sub-slice modification:", slice)

	// Creating slices with `make`
	madeSlice := make([]string, 3, 5) // type, length, capacity (optional)
	madeSlice[0] = "a"
	madeSlice[1] = "b"
	madeSlice[2] = "c"
	fmt.Println("Made Slice:", madeSlice, "Len:", len(madeSlice), "Cap:", cap(madeSlice))

	// Appending to slices (may return a new underlying array if capacity is exceeded)
	madeSlice = append(madeSlice, "d", "e")
	fmt.Println("Appended Slice:", madeSlice, "Len:", len(madeSlice), "Cap:", cap(madeSlice))
	madeSlice = append(madeSlice, "f") // Capacity exceeded, new array allocated
	fmt.Println("Appended Again:", madeSlice, "Len:", len(madeSlice), "Cap:", cap(madeSlice))

	// Iterating over slices (and arrays, maps, strings) using `range`
	fmt.Println("Iterating over slice with range:")
	for index, value := range slice {
		fmt.Printf("Index: %d, Value: %d\n", index, value)
	}
	// If you only need the value:
	for _, value := range slice {
		fmt.Printf("Value: %d\n", value)
	}

	// Maps (key-value pairs, unordered)
	// Using `make`
	ages := make(map[string]int)
	ages["Alice"] = 30
	ages["Bob"] = 25
	fmt.Println("Map:", ages)

	// Map literal
	colors := map[string]string{
		"red":   "#FF0000",
		"green": "#00FF00",
		"blue":  "#0000FF",
	}
	fmt.Println("Colors Map:", colors)
	fmt.Println("Alice's age:", ages["Alice"])

	// Deleting from a map
	delete(ages, "Bob")
	fmt.Println("Map after deleting Bob:", ages)

	// Checking if a key exists (comma ok idiom)
	age, ok := ages["Charlie"]
	if !ok {
		fmt.Println("Charlie's age not found.")
	} else {
		fmt.Println("Charlie's age:", age) // This won't run in this case
	}
	_, bobExists := ages["Bob"]
	fmt.Println("Does Bob exist in map?", bobExists) // false

	// Iterating over maps with range
	fmt.Println("Iterating over colors map:")
	for key, value := range colors {
		fmt.Printf("Key: %s, Value: %s\n", key, value)
	}

	// --- Structs Instantiation ---
	person1 := Person{"Alice", "Smith", 30}
	fmt.Println("Person 1:", person1)
	person2 := Person{FirstName: "Bob", Age: 25} // LastName gets zero value ("")
	fmt.Println("Person 2:", person2)

	// Using embedded struct
	emp1 := Employee{
		Person:     Person{FirstName: "Charlie", LastName: "Brown", Age: 40},
		EmployeeID: 12345,
		Department: "Engineering",
	}
	fmt.Println("Employee:", emp1)
	// Accessing promoted fields directly
	fmt.Printf("Employee Name: %s %s, Dept: %s\n", emp1.FirstName, emp1.LastName, emp1.Department)

	// --- Function Calls ---
	sumResult, diffResult := addAndSubtract(10, 5)
	fmt.Printf("Add/Subtract: %d, %d\n", sumResult, diffResult)

	quot, err := divide(10.0, 2.0)
	if err != nil {
		fmt.Println("Error dividing:", err)
	} else {
		fmt.Printf("Division result: %.2f\n", quot)
	}
	_, errZero := divide(5.0, 0.0)
	if errZero != nil {
		fmt.Println("Error dividing by zero:", errZero) // This will print
	}

	totalSum := sumNumbers(1, 2, 3, 4, 5)
	fmt.Println("Variadic Sum:", totalSum)
	// Can also pass a slice to a variadic function using `...`
	numsToSum := []int{10, 20, 30}
	fmt.Println("Variadic Sum from slice:", sumNumbers(numsToSum...))

	// Anonymous functions (Closures)
	// Functions are first-class citizens
	adder := func(a, b int) int {
		return a + b
	}
	fmt.Println("Anonymous function result:", adder(5, 3))

	// Closures: Anonymous functions can access variables from their lexical scope
	x := 10
	incrementer := func() int {
		x++ // Accesses and modifies 'x' from the outer scope
		return x
	}
	fmt.Println("Incrementer call 1:", incrementer()) // 11
	fmt.Println("Incrementer call 2:", incrementer()) // 12
	fmt.Println("Original x:", x)                     // 12

	// Recursion Example
	fmt.Println("Factorial of 5:", factorial(5))

	// --- Pointers Example ---
	ptrVal := 20
	fmt.Println("Original ptrVal:", ptrVal)
	increment(&ptrVal) // Pass the address of ptrVal
	fmt.Println("ptrVal after increment function:", ptrVal) // Value is changed

	var nilPtr *int // Declare a nil pointer
	increment(nilPtr) // Call with nil pointer (function handles it)

	// --- Methods and Interfaces ---
	rect := Rectangle{Width: 10, Height: 5}
	circ := Circle{Radius: 7}

	fmt.Println("Rectangle:", rect.String()) // Calling Stringer method
	fmt.Printf("Rectangle Area: %.2f, Perimeter: %.2f\n", rect.Area(), rect.Perimeter())
	fmt.Printf("Circle Area: %.2f, Perimeter: %.2f\n", circ.Area(), circ.Perimeter())

	// Using interfaces: A function that works with any Shaper
	printShapeInfo := func(s Shaper) {
		// The type of 's' is Shaper, but its underlying value can be Rectangle, Circle, etc.
		fmt.Printf("Shape Info: Type=%T, Area=%.2f, Perimeter=%.2f\n", s, s.Area(), s.Perimeter())
		// Type Assertion (to access specific type fields if needed)
		if r, ok := s.(Rectangle); ok {
			fmt.Printf("  (It's a Rectangle! Width: %.2f)\n", r.Width)
		} else if c, ok := s.(Circle); ok {
			fmt.Printf("  (It's a Circle! Radius: %.2f)\n", c.Radius)
		}
	}

	printShapeInfo(rect)
	printShapeInfo(circ)

	// Type Switch (another way to handle different concrete types in an interface value)
	checkType := func(i interface{}) { // interface{} means any type
		switch v := i.(type) {
		case int:
			fmt.Printf("Type Switch: It's an int: %d\n", v)
		case string:
			fmt.Printf("Type Switch: It's a string: %s\n", v)
		case Rectangle:
			fmt.Printf("Type Switch: It's a Rectangle: Width=%.2f\n", v.Width)
		case Shaper:
			fmt.Printf("Type Switch: It's a Shaper with area %.2f\n", v.Area())
		default:
			fmt.Printf("Type Switch: Unknown type: %T\n", v)
		}
	}
	checkType(42)
	checkType("hello")
	checkType(rect)
	checkType(3.14)

	// Pointer Receivers Example
	myCounter := &Counter{} // Create a pointer to a Counter
	fmt.Println("Initial Counter Value:", myCounter.Value())
	myCounter.Increment()
	myCounter.Increment()
	fmt.Println("Counter Value after increments:", myCounter.Value()) // Calls Value() method correctly
	
	var nilCounter *Counter
	nilCounter.Increment() // Handles nil receiver
	fmt.Println("Nil Counter Value:", nilCounter.Value()) // Handles nil receiver

	// --- Defer Statement ---
	// `defer` schedules a function call to be run just before the function executing the `defer` returns.
	// Useful for cleanup actions like closing files or unlocking mutexes.
	// Deferred calls are executed in Last-In, First-Out (LIFO) order.
	fmt.Println("\n--- Defer Demo ---")
	defer fmt.Println("Deferred: This prints third (at the end of main).")
	defer fmt.Println("Deferred: This prints second.")
	fmt.Println("Defer Demo: This prints first.")
	// Example simulating file close
	openFile := func(name string) { fmt.Printf("Opening file: %s\n", name) }
	closeFile := func(name string) { fmt.Printf("Closing file: %s\n", name) }
	openFile("mydata.txt")
	defer closeFile("mydata.txt") // Ensure file gets closed when main exits
	fmt.Println("Defer Demo: File processing simulation...")
	fmt.Println("--- End Defer Demo ---")

	// --- Error Handling ---
	// Already shown in `divide` function. Go uses explicit error checking.
	valStr := "123"
	numVal, err := strconv.Atoi(valStr) // Attempt to convert string to int
	if err != nil {
		// This block *won't* execute for "123"
		fmt.Printf("Error converting string '%s' to int: %v\n", valStr, err)
	} else {
		fmt.Printf("Successfully converted '%s' to int: %d\n", valStr, numVal)
	}

	valStr = "abc"
	numVal, err = strconv.Atoi(valStr)
	if err != nil {
		// This block *will* execute for "abc"
		fmt.Printf("Error converting string '%s' to int: %v\n", valStr, err)
	} else {
		fmt.Printf("Successfully converted '%s' to int: %d\n", valStr, numVal) // Unreachable
	}

	// Creating custom errors
	myErr := fmt.Errorf("this is a custom error with value %d", 42)
	fmt.Println("Custom error:", myErr)

	// --- Concurrency (Goroutines and Channels) ---
	fmt.Println("\n--- Concurrency Demo ---")

	// Goroutine: A lightweight thread managed by the Go runtime.
	// Launch a function call in a new goroutine using the `go` keyword.
	simpleGoroutine := func(id int) {
		fmt.Printf("Goroutine %d: Working...\n", id)
		time.Sleep(50 * time.Millisecond) // Simulate work
		fmt.Printf("Goroutine %d: Finished.\n", id)
	}

	go simpleGoroutine(1) // Start goroutine 1
	go simpleGoroutine(2) // Start goroutine 2

	// If main exits, the program exits, potentially before goroutines finish.
	// We need synchronization. Using time.Sleep here is bad practice, just for demo.
	fmt.Println("Main: Waiting briefly for goroutines (bad practice)...")
	time.Sleep(100 * time.Millisecond)

	// Better synchronization using WaitGroup
	var wg sync.WaitGroup // Create a WaitGroup

	worker := func(id int, wg *sync.WaitGroup) {
		defer wg.Done() // Decrement the counter when the goroutine finishes
		fmt.Printf("Worker %d: Starting\n", id)
		time.Sleep(time.Duration(id*50) * time.Millisecond) // Simulate work
		fmt.Printf("Worker %d: Finished\n", id)
	}

	numWorkers := 3
	for i := 1; i <= numWorkers; i++ {
		wg.Add(1) // Increment the counter for each goroutine to launch
		go worker(i, &wg)
	}

	fmt.Println("Main: Waiting for workers using WaitGroup...")
	wg.Wait() // Block until the WaitGroup counter goes back to 0
	fmt.Println("Main: All workers finished.")

	// Channels: Typed conduits for communication between goroutines.
	// Create channels using `make(chan Type, [bufferSize])`
	messageChannel := make(chan string) // Unbuffered channel

	// Goroutine sending a message
	go func() {
		fmt.Println("Sender Goroutine: Sending message...")
		time.Sleep(100 * time.Millisecond) // Simulate work before sending
		messageChannel <- "Hello from the Channel!" // Send operation (blocks until receiver is ready)
		fmt.Println("Sender Goroutine: Message sent.")
	}()

	// Main goroutine receiving the message
	fmt.Println("Receiver (Main): Waiting for message...")
	msg := <-messageChannel // Receive operation (blocks until sender sends)
	fmt.Println("Receiver (Main): Received message:", msg)

	// Buffered Channels (don't block sender until buffer is full)
	bufferedChan := make(chan int, 2) // Buffer size of 2
	bufferedChan <- 1                 // Send doesn't block
	bufferedChan <- 2                 // Send doesn't block
	// bufferedChan <- 3              // This would block until a receive happens
	fmt.Println("Buffered Channel Receive 1:", <-bufferedChan)
	fmt.Println("Buffered Channel Receive 2:", <-bufferedChan)

	// `range` over channels and `close`
	jobs := make(chan int, 5)
	done := make(chan bool)

	go func() {
		// This worker goroutine receives jobs from the 'jobs' channel
		// The `range jobs` loop automatically detects when the channel is closed.
		for j := range jobs {
			fmt.Printf("Worker received job %d\n", j)
			time.Sleep(50 * time.Millisecond) // Simulate work
		}
		fmt.Println("Worker finished processing all jobs.")
		done <- true // Signal that all jobs are done
	}()

	// Main goroutine sends jobs to the worker
	for j := 1; j <= 3; j++ {
		fmt.Printf("Main sending job %d\n", j)
		jobs <- j
	}
	close(jobs) // Close the channel - signals no more jobs will be sent
	fmt.Println("Main sent all jobs and closed channel.")

	<-done // Wait for the worker to finish (receive from 'done' channel)
	fmt.Println("Main confirmed worker is done.")

	// `select` statement: Wait on multiple channel operations.
	chan1 := make(chan string, 1)
	chan2 := make(chan string, 1)

	go func() {
		time.Sleep(100 * time.Millisecond)
		chan1 <- "one"
	}()
	go func() {
		time.Sleep(50 * time.Millisecond) // This one is faster
		chan2 <- "two"
	}()

	// Select waits until one of its cases can run, then it executes that case.
	// If multiple are ready, it chooses one at random.
	fmt.Println("Select: Waiting for channel activity...")
	for i := 0; i < 2; i++ { // We expect two messages
		select {
		case msg1 := <-chan1:
			fmt.Println("Select: Received from chan1:", msg1)
		case msg2 := <-chan2:
			fmt.Println("Select: Received from chan2:", msg2)
			// case <-time.After(1 * time.Second): // Timeout example
			//     fmt.Println("Select: Timeout occurred")
			//     return
			// default: // Runs if no other case is ready (non-blocking select)
			//     fmt.Println("Select: No activity")
			//     time.Sleep(20 * time.Millisecond)
		}
	}
	fmt.Println("--- End Concurrency Demo ---")

	// --- Panic and Recover ---
	// Panic stops the ordinary flow of control and begins panicking.
	// Recover stops a panic. It's only useful inside deferred functions.
	// Generally used for truly exceptional/unrecoverable errors, not standard error handling.
	fmt.Println("\n--- Panic/Recover Demo ---")
	func() {
		defer func() {
			// The 'recover' built-in function stops the panicking sequence
			if r := recover(); r != nil {
				fmt.Printf("Recovered from panic: %v\n", r)
				fmt.Println("Program continues after recovery.")
			} else {
				fmt.Println("No panic occurred (this won't print if mayPanic panics).")
			}
		}() // Call the deferred anonymous function

		mayPanic := func(shouldPanic bool) {
			fmt.Println("Inside mayPanic...")
			if shouldPanic {
				fmt.Println("Oh no, initiating panic!")
				panic("something went terribly wrong") // Argument passed to recover()
			}
			fmt.Println("mayPanic finished normally.") // This won't print if panic occurs
		}

		mayPanic(true) // Trigger the panic
		fmt.Println("After mayPanic call (this won't print if panic occurs and isn't recovered).")

	}() // Call the outer anonymous function to scope the defer/recover

	fmt.Println("--- End Panic/Recover Demo ---")

	fmt.Println("\n--- End of Go Demonstration ---")
	// The deferred calls from earlier will execute now, just before main returns.
} // End of main function

// --- End of File ---
