//! Rust Comprehensive Example File
//! This file demonstrates various features of the Rust programming language.
//! Note: This is illustrative, not exhaustive or necessarily idiomatic for a real project.

// Import necessary items from the standard library
use std::collections::HashMap;
use std::fmt; // For implementing Display trait
use std::thread;
use std::time::Duration;

// === 1. Basic Syntax: Variables, Data Types, Comments ===

// Line comment

/*
 Block
 Comment
*/

/// Doc comment for the main function (used by rustdoc)
fn main() {
    println!("--- Rust Feature Showcase ---");

    // Immutable variable binding (type inferred)
    let an_integer = 42;
    // Mutable variable binding (type annotated)
    let mut a_float: f64 = 3.14;

    println!("Integer: {}, Mutable Float: {}", an_integer, a_float);
    a_float = 2.71; // Can mutate `a_float`
    println!("Mutated float: {}", a_float); 

    // Basic types
    let _is_active: bool = true;
    let _a_char: char = '🚀';
    let _an_unsigned_int: u32 = 100;

    // Tuples: Grouping fixed number of values of potentially different types
    let tup: (i32, f64, char) = (500, 6.4, '✅');
    let (x, y, _z) = tup; // Destructuring the tuple
    println!("Tuple elements: x={}, y={}", x, y);
    println!("Accessing tuple element by index: {}", tup.0);

    // Arrays: Fixed size, same type elements (stack allocated)
    let array: [i32; 3] = [1, 2, 3];
    println!("First array element: {}", array[0]);

    // === 2. Control Flow ===
    println!("\n--- Control Flow ---");
    control_flow_example(7);
    loop_examples();

    // === 3. Functions ===
    println!("\n--- Functions ---");
    let sum = add_numbers(10, 5);
    println!("Sum from function: {}", sum);
    let fact = factorial(5);
    println!("Factorial of 5 (recursive): {}", fact);

    // === 4. Ownership & Borrowing ===
    println!("\n--- Ownership & Borrowing ---");
    ownership_demo();
    borrowing_demo();

    // === 5. Structs ===
    println!("\n--- Structs ---");
    // Instantiate a struct
    let mut user1 = User {
        username: String::from("john_doe"),
        email: String::from("john@example.com"),
        sign_in_count: 1,
        active: true,
    };
    println!("User: {}, Email: {}", user1.username, user1.email);
    user1.email = String::from("john.doe@newdomain.com"); // Mutable field
    println!("User sign-ins: {}, Active: {}", user1.sign_in_count, user1.active);

    // Tuple struct
    let black = Color(0, 0, 0);
    println!("Color: ({}, {}, {})", black.0, black.1, black.2);

    // Unit-like struct (useful for traits)
    let _marker = AlwaysEqual;

    // === 6. Enums ===
    println!("\n--- Enums ---");
    let msg1 = Message::Write(String::from("Hello from enum!"));
    let msg2 = Message::ChangeColor(10, 20, 30);
    let msg3 = Message::Quit;
    let msg4 = Message::Move { x: 50, y: -10 }; // Construct the Move variant
    process_message(msg1);
    process_message(msg2);
    process_message(msg3);
    process_message(msg4);

    // === 7. Methods ===
    println!("\n--- Methods ---");
    let rect = Rectangle { width: 30, height: 50 };
    println!("Rectangle area: {}", rect.area());
    println!("Can rect hold another? {}", rect.can_hold(&Rectangle { width: 10, height: 40 }));
    // Associated function (like static method)
    let square = Rectangle::square(25);
    println!("Square area: {}", square.area());

    // === 8. Traits (Polymorphism) ===
    println!("\n--- Traits ---");
    let tweet = Tweet {
        username: String::from("horse_ebooks"),
        content: String::from("of course, as you probably already know"),
        reply: false,
        retweet: false,
    };
    let article = NewsArticle {
        headline: String::from("Penguins win the Stanley Cup Championship!"),
        location: String::from("Pittsburgh, PA, USA"),
        author: String::from("Iceburgh"),
        content: String::from("The Pittsburgh Penguins once again are the best hockey team in the NHL."),
    };
    println!("Tweet summary: {}", tweet.summarize());
    println!("Article summary: {}", article.summarize());
    // Using the trait object for dynamic dispatch
    notify(&tweet);
    notify(&article);
    // Using Display trait we implemented for Rectangle
    println!("Rectangle Display: {}", rect);

    // === 9. Generics ===
    println!("\n--- Generics ---");
    let number_list = vec![34, 50, 25, 100, 65];
    let largest_num = largest(&number_list);
    println!("Largest number: {}", largest_num);

    let char_list = vec!['y', 'm', 'c', 'a'];
    let largest_char = largest(&char_list);
    println!("Largest char: {}", largest_char);

    let p1: Point<i32> = Point { x: 5, y: 10 };
    let p2: Point<f64> = Point { x: 1.0, y: 4.0 };
    println!("Generic Point: x = {}, y = {}", p1.x, p1.y()); // Using method on generic struct
    println!("Generic Point: x = {}, y = {}", p2.x, p2.y());

    // === 10. Error Handling (Option & Result) ===
    println!("\n--- Error Handling ---");
    let numbers = vec![1, 2, 3, 4, 5];
    match find_item(&numbers, 3) {
        Some(index) => println!("Found 3 at index: {}", index),
        None => println!("3 not found in the list."),
    }
    match find_item(&numbers, 6) {
        Some(index) => println!("Found 6 at index: {}", index),
        None => println!("6 not found in the list."),
    }

    match divide(10.0, 2.0) {
        Ok(result) => println!("10.0 / 2.0 = {}", result),
        Err(e) => println!("Error: {}", e),
    }
    match divide(10.0, 0.0) {
        Ok(result) => println!("10.0 / 0.0 = {}", result), // This won't happen
        Err(e) => println!("Error: {}", e),
    }
    // Using the `?` operator for propagation
    match process_division(20.0, 5.0) {
        Ok(res) => println!("Processed division result: {}", res),
        Err(e) => println!("Processing error: {}", e),
    }
     match process_division(20.0, 0.0) {
        Ok(res) => println!("Processed division result: {}", res),
        Err(e) => println!("Processing error: {}", e),
    }


    // === 11. Collections ===
    println!("\n--- Collections ---");
    // Vector (Vec<T>) - growable array
    let mut my_vec: Vec<i32> = Vec::new();
    my_vec.push(10);
    my_vec.push(20);
    my_vec.push(30);
    println!("Vector: {:?}", my_vec); // Debug print format
    let third = my_vec.get(2); // Returns Option<&i32>
    if let Some(val) = third {
        println!("Third element: {}", val);
    }
    // Using vec! macro
    let v2 = vec![100, 200, 300];
    for i in &v2 { // Iterate by reference
        println!("Vec item: {}", i);
    }

    // HashMap<K, V> - key-value store
    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);
    let team_name = String::from("Blue");
    let score = scores.get(&team_name); // Returns Option<&V>
    match score {
        Some(s) => println!("Score for Blue team: {}", s),
        None => println!("Blue team not found."),
    }
    // Iterate over HashMap
    for (key, value) in &scores {
        println!("{}: {}", key, value);
    }

    // === 12. Strings ===
    println!("\n--- Strings ---");
    // &str - string slice (reference to UTF-8 encoded string data)
    let s1: &str = "Hello";
    // String - owned, growable string (heap allocated)
    let mut s2: String = String::from("World");
    s2.push_str("!"); // Append a string slice
    s2.push(' '); // Append a char
    println!("String slice: {}, Owned String: {}", s1, s2);
    let s3 = s1.to_string() + " " + &s2; // Concatenation (takes ownership of s1's String conversion)
    println!("Concatenated: {}", s3);
    let s4 = format!("{}-{}", s1, s2); // format! macro (doesn't take ownership)
    println!("Formatted: {}", s4);
    // Slicing strings (be careful with UTF-8 boundaries)
    let hello = &s4[0..5]; // "Hello"
    println!("Slice of s4: {}", hello);

    // === 13. Modules ===
    println!("\n--- Modules ---");
    my_module::public_function();
    // my_module::private_function(); // Error: private_function is private
    my_module::nested::nested_function();
    // Use statement example (see top of file) - HashMap is used directly

    // === 14. Macros ===
    println!("\n--- Macros ---");
    // We've been using println!, vec!, format!
    // Simple custom declarative macro:
    macro_rules! my_macro {
        () => {
            println!("My macro was called!");
        };
        ($x:expr) => {
            println!("My macro received expression: {}", $x);
        };
    }
    my_macro!();
    my_macro!(1 + 2);

    // === 15. Lifetimes ===
    println!("\n--- Lifetimes ---");
    let string1 = String::from("abcd");
    // let result: &str; // 'result' is no longer assigned to in a way that outlives the block below

    { // Inner Scope Starts
        let string2 = String::from("xy");

        // Call 'longest' and use the result *within this scope* where both inputs are valid.
        let inner_result = longest(string1.as_str(), string2.as_str());
        println!("The longest string inside the inner scope is: {}", inner_result);

        // We CANNOT assign inner_result to an outer variable 'result' here,
        // because inner_result's lifetime is tied to 'string2', which ends at the '}'.
        // result = longest(string1.as_str(), string2.as_str()); // <-- COMPILER ERROR E0597

    } // Inner Scope Ends - string2 is dropped, inner_result reference becomes invalid.

    // Since 'result' was never assigned a value, this line would cause an error.
    // println!("Result outside inner scope: {}", result); // <-- REMOVED

    // We can separately show that a reference to string1 *can* live long:
    let long_lived_ref = string1.as_str();
    println!("string1 reference still valid here: {}", long_lived_ref);


    let _string3 = String::from("Short");
    // Demonstrating how result cannot outlive string3 if it borrows from it
    // let result_outer = longest(string1.as_str(), _string3.as_str()); // This works fine
    // Let's try to make it fail (compiler prevents this usually):
    // {
    //     let string4 = String::from("Temporary String");
    //     let result_outer = longest(string4.as_str(), _string3.as_str()); // Compiler Error: `string4` does not live long enough
    // }
    // println!("{}", result_outer);


    // === 16. Closures ===
    println!("\n--- Closures ---");
    let doubler = |x: i32| -> i32 { x * 2 };
    println!("Doubler closure: 5 * 2 = {}", doubler(5));

    // Closures can capture their environment
    let factor = 10;
    let multiplier = |x| x * factor; // Captures `factor` by reference (Fn trait)
    println!("Multiplier closure: 6 * {} = {}", factor, multiplier(6));

    // Example using a closure with iterator adapter
    let doubled_numbers: Vec<_> = numbers.iter().map(|&x| x * 2).collect();
    println!("Doubled numbers using map and closure: {:?}", doubled_numbers);


    // === 17. Concurrency ===
    println!("\n--- Concurrency (Basic Threads) ---");
    let handle = thread::spawn(|| {
        for i in 1..=3 {
            println!("Hi number {} from the spawned thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    });

    // Do other work in the main thread
    for i in 1..=2 {
        println!("Hi number {} from the main thread!", i);
        thread::sleep(Duration::from_millis(1));
    }

    handle.join().unwrap(); // Wait for the spawned thread to finish
    println!("Spawned thread finished.");


    println!("\n--- End of Showcase ---");
} // End of main function

// === Function Definitions ===

/// Adds two i32 numbers.
fn add_numbers(x: i32, y: i32) -> i32 {
    x + y // Implicit return (no semicolon)
}

/// Calculates factorial recursively.
fn factorial(n: u64) -> u64 {
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)
    }
}

/// Demonstrates basic control flow.
fn control_flow_example(number: i32) {
    if number % 4 == 0 {
        println!("{} is divisible by 4", number);
    } else if number % 3 == 0 {
        println!("{} is divisible by 3", number);
    } else if number % 2 == 0 {
        println!("{} is divisible by 2", number);
    } else {
        println!("{} is not divisible by 4, 3, or 2", number);
    }

    // `if` is an expression
    let condition = true;
    let value = if condition { 5 } else { 6 };
    println!("The value from if expression is: {}", value);
}

/// Demonstrates different loop types.
fn loop_examples() {
    // Infinite loop with break
    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 10 {
            break counter * 2; // Return a value from the loop
        }
    };
    println!("Loop result: {}", result);

    // While loop
    let mut number = 3;
    while number != 0 {
        println!("{}!", number);
        number -= 1;
    }
    println!("WHILE loop finished!");

    // For loop (iterating over a range)
    for i in 1..4 { // 1, 2, 3 (exclusive end)
        println!("For loop (1..4): {}", i);
    }
     for i in 1..=4 { // 1, 2, 3, 4 (inclusive end)
        println!("For loop (1..=4): {}", i);
    }

    // For loop (iterating over collection)
    let a = [10, 20, 30, 40, 50];
    for element in a.iter() { // Using iter() to borrow elements
        println!("Array element: {}", element);
    }
}

// === Ownership & Borrowing Functions ===

/// Demonstrates ownership transfer.
fn ownership_demo() {
    let s1 = String::from("hello"); // s1 owns the String data
    takes_ownership(s1); // s1's ownership is moved into the function
    // println!("{}", s1); // Error! s1 is no longer valid here

    let x = 5; // x is i32, which implements the Copy trait
    makes_copy(x); // A copy of x is passed to the function
    println!("x is still valid: {}", x); // x is still valid here
}

fn takes_ownership(some_string: String) {
    println!("Inside takes_ownership: {}", some_string);
} // `some_string` goes out of scope, `drop` is called. Memory is freed.

fn makes_copy(some_integer: i32) {
    println!("Inside makes_copy: {}", some_integer);
} // `some_integer` goes out of scope. Nothing special happens for Copy types.

/// Demonstrates borrowing (references).
fn borrowing_demo() {
    let s1 = String::from("world");

    // Pass an immutable reference (&) - borrows s1
    let len = calculate_length(&s1);
    println!("The length of '{}' is {}.", s1, len); // s1 is still valid

    let mut s2 = String::from("mutable");
    // Pass a mutable reference (&mut) - mutably borrows s2
    change_string(&mut s2);
    println!("Changed string: {}", s2); // s2 has been modified
}

fn calculate_length(s: &String) -> usize { // `s` is a reference to a String
    s.len()
} // `s` goes out of scope, but does *not* drop what it refers to.

fn change_string(some_string: &mut String) { // takes a mutable reference
    some_string.push_str(" changed");
}

// === Struct Definitions ===

/// Represents a user account.
struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}

/// A tuple struct for RGB color.
struct Color(u8, u8, u8);

/// A unit-like struct (no fields).
struct AlwaysEqual;

// === Enum Definition ===

/// Represents different types of messages.
enum Message {
    Quit,                       // No data associated
    Move { x: i32, y: i32 },    // Anonymous struct variant
    Write(String),              // Includes a String
    ChangeColor(u8, u8, u8), // Includes three u8 values
}

/// Processes a Message enum.
fn process_message(msg: Message) {
    match msg {
        Message::Quit => println!("Message: Quit"),
        Message::Move { x, y } => println!("Message: Move to x={}, y={}", x, y),
        Message::Write(text) => println!("Message: Write - {}", text),
        Message::ChangeColor(r, g, b) => println!("Message: ChangeColor to ({}, {}, {})", r, g, b),
    }
}

// === Methods (`impl`) ===

#[derive(Debug)] // Auto-implement Debug trait for printing
struct Rectangle {
    width: u32,
    height: u32,
}

// Implementation block for Rectangle
impl Rectangle {
    /// Calculates the area of the rectangle.
    fn area(&self) -> u32 { // `&self` is shorthand for `self: &Self` (immutable borrow)
        self.width * self.height
    }

    /// Checks if this rectangle can hold another rectangle.
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }

    /// Associated function (like a static method) to create a square.
    fn square(size: u32) -> Rectangle { // No `self` parameter
        Rectangle { width: size, height: size }
    }
}

// We can implement traits on our types
impl fmt::Display for Rectangle {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Rectangle({}x{})", self.width, self.height)
    }
}


// === Traits (Interfaces) ===

/// Defines summarizable behavior.
pub trait Summary {
    // Method signature (requires implementation)
    fn summarize_author(&self) -> String;

    // Method with default implementation
    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}

pub struct NewsArticle {
    pub headline: String,
    pub location: String,
    pub author: String,
    pub content: String,
}

impl Summary for NewsArticle {
    fn summarize_author(&self) -> String {
        format!("@{}", self.author)
    }
    // Uses the default summarize method
}

pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool,
}

impl Summary for Tweet {
    fn summarize_author(&self) -> String {
        format!("@{}", self.username)
    }

    // Override the default summarize method
    fn summarize(&self) -> String {
        format!("{}: {}", self.summarize_author(), self.content)
    }
}

// Function that accepts any type implementing the Summary trait (static dispatch via monomorphization)
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}

// Function accepting a trait object (dynamic dispatch)
// pub fn notify_dynamic(item: &dyn Summary) {
//    println!("Breaking news (dynamic)! {}", item.summarize());
// }


// === Generics ===

/// Finds the largest item in a slice.
/// Works for any type T that implements PartialOrd (for comparison >) and Copy.
// fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
//     let mut largest = list[0];
//     for &item in list {
//         if item > largest {
//             largest = item;
//         }
//     }
//     largest
// }
// Version returning a reference (avoids Copy requirement, but needs lifetimes)
fn largest<T: PartialOrd>(list: &[T]) -> &T {
     if list.is_empty() {
        panic!("Cannot find largest in empty list");
    }
    let mut largest = &list[0];
    for item in list.iter() {
        if item > largest {
            largest = item;
        }
    }
    largest
}


/// A generic Point struct.
struct Point<T> {
    x: T,
    y: T,
}

// Implement methods on the generic Point<T>
impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
    fn y(&self) -> &T {
        &self.y
    }
}

// === Error Handling Functions ===

/// Finds the index of an item in a slice, returning Option<usize>.
fn find_item(haystack: &[i32], needle: i32) -> Option<usize> {
    for (index, &item) in haystack.iter().enumerate() {
        if item == needle {
            return Some(index); // Found it!
        }
    }
    None // Not found
}

/// Divides two f64 numbers, returning Result<f64, String>.
fn divide(numerator: f64, denominator: f64) -> Result<f64, String> {
    if denominator == 0.0 {
        Err(String::from("Cannot divide by zero!"))
    } else {
        Ok(numerator / denominator)
    }
}

/// Demonstrates propagating errors using the `?` operator.
fn process_division(num: f64, den: f64) -> Result<f64, String> {
    let result = divide(num, den)?; // If divide returns Err, this function returns the Err immediately
    // ... do more processing if needed ...
    println!("Division successful, proceeding...");
    Ok(result * 2.0) // Return Ok wrapping the final value
}


// === Lifetimes ===

/// Returns the longest of two string slices.
/// The lifetime 'a annotation ensures the returned reference is valid
/// for as long as *both* input references are valid.
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
// Note: Often, lifetimes are inferred by the compiler (lifetime elision),
// but explicit annotation is needed in ambiguous cases like this function.


// === Modules ===

mod my_module {
    // Items are private by default

    /// This function is public and can be called from outside `my_module`.
    pub fn public_function() {
        println!("Called my_module::public_function()");
        private_function(); // Can call private functions within the same module
    }

    /// This function is private.
    fn private_function() {
        println!("Called my_module::private_function()");
    }

    // Nested module
    pub mod nested {
         /// Public function in a nested module.
        pub fn nested_function() {
            println!("Called my_module::nested::nested_function()");
        }
    }

    // You can also have structs, enums, traits, etc., inside modules
    // Use `pub` to make them accessible outside.
    pub struct PublicStruct {
        pub field: i32, // Fields can also be public or private
        private_field: bool,
    }

    impl PublicStruct {
         pub fn new(val: i32) -> Self {
             PublicStruct { field: val, private_field: false }
         }
    }
}

// === End of File ===
