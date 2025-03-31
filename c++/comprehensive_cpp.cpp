/**
 * Comprehensive C++ Demonstration File (Corrected)
 *
 * This file aims to showcase a wide variety of C++ syntax, statements,
 * and core language features. It's not exhaustive but covers fundamental
 * concepts through advanced topics like OOP, templates, and the STL.
 *
 * Compile using a C++14 compliant compiler (or later) because
 * this code uses std::make_unique (introduced in C++14).
 * Example compilation command:
 * g++ -std=c++14 -o comprehensive_cpp comprehensive_cpp.cpp
 * # Or using a later standard:
 * # g++ -std=c++17 -o comprehensive_cpp comprehensive_cpp.cpp
 *
 * Run the compiled program:
 * ./comprehensive_cpp
 */

// ---===[ 1. Basic Syntax: Includes and Namespaces ]===---
#include <iostream>  // For standard I/O (cout, cin)
#include <vector>    // For std::vector (STL container)
#include <string>    // For std::string (STL container)
#include <map>       // For std::map (STL container)
#include <algorithm> // For STL algorithms (sort, find, for_each, count_if)
#include <memory>    // For smart pointers (unique_ptr, shared_ptr, make_unique, make_shared)
#include <stdexcept> // For standard exceptions (runtime_error)
#include <fstream>   // For file I/O (ofstream, ifstream)
#include <cmath>     // For mathematical functions (abs) - Example usage
#include <utility>   // Often included indirectly, but good to have for std::move, std::pair

// Using the standard namespace to avoid prefixing std:: everywhere
// Note: In larger projects, it's often better to use specific 'using' declarations
// (e.g., using std::cout;) or fully qualify names (std::cout) to avoid name clashes.
// Even with 'using namespace std;', qualifying std::move is often preferred.
using namespace std;

// Forward declarations (telling the compiler about things defined later)
class Shape;
class Circle;
class Rectangle;
void demonstrateFunctions();
void demonstrateOOP();
void demonstrateTemplates();
void demonstrateSTL();
void demonstrateExceptions();
void demonstrateMemoryManagement();
void demonstrateModernFeatures();
void demonstrateFileIO();

// ---===[ 2. Data Types and Variables ]===---
void demonstrateDataTypes() {
    cout << "\n---===[ 2. Data Types and Variables ]===---" << endl;

    // Primitive Types
    int integerVar = 42;
    double doubleVar = 3.14159;
    float floatVar = 2.718f; // 'f' suffix for float literals
    char charVar = 'C';
    bool boolVar = true; // or false
    long long longLongVar = 1234567890123LL; // 'LL' suffix

    cout << "Int: " << integerVar << ", Double: " << doubleVar << endl;
    cout << "Float: " << floatVar << ", Char: " << charVar << ", Bool: " << boolVar << endl;
    cout << "Long Long: " << longLongVar << endl;

    // Type Deduction (C++11 onwards)
    auto inferredInt = 100;     // Inferred as int
    auto inferredDouble = 3.0;  // Inferred as double
    auto inferredString = "Auto"; // Inferred as const char* (careful!) Use string("Auto") for std::string
    cout << "Auto inferred int: " << inferredInt << ", double: " << inferredDouble << endl;

    // Constants
    const double PI = 3.1415926535;
    // PI = 3.14; // Error: Cannot assign to const variable
    cout << "Constant PI: " << PI << endl;

    // Enum (Strongly-typed enum class recommended since C++11)
    enum class Color { RED, GREEN, BLUE };
    Color myColor = Color::GREEN;
    // if (myColor == 1) {} // Error: Cannot compare enum class directly to int
    if (myColor == Color::GREEN) {
        cout << "Color is GREEN" << endl;
    }
}

// ---===[ 3. Operators ]===---
void demonstrateOperators() {
    cout << "\n---===[ 3. Operators ]===---" << endl;
    int a = 10, b = 3;

    // Arithmetic
    cout << "a + b = " << (a + b) << endl; // 13
    cout << "a - b = " << (a - b) << endl; // 7
    cout << "a * b = " << (a * b) << endl; // 30
    cout << "a / b = " << (a / b) << endl; // 3 (integer division)
    cout << "a % b = " << (a % b) << endl; // 1 (modulo)

    // Comparison (result in bool: true/false, often printed as 1/0)
    cout << "a > b: " << (a > b) << endl;   // 1 (true)
    cout << "a == 10: " << (a == 10) << endl; // 1 (true)
    cout << "a != b: " << (a != b) << endl;   // 1 (true)

    // Logical
    bool condition1 = true;
    bool condition2 = false;
    cout << "condition1 && condition2: " << (condition1 && condition2) << endl; // 0 (false)
    cout << "condition1 || condition2: " << (condition1 || condition2) << endl; // 1 (true)
    cout << "!condition1: " << (!condition1) << endl;             // 0 (false)

    // Bitwise
    int x = 5; // Binary 0101
    int y = 3; // Binary 0011
    cout << "x & y = " << (x & y) << endl; // 1 (0001 - AND)
    cout << "x | y = " << (x | y) << endl; // 7 (0111 - OR)
    cout << "x ^ y = " << (x ^ y) << endl; // 6 (0110 - XOR)
    cout << "~x = " << (~x) << endl; // -6 (Depends on int size/representation - NOT)
    cout << "x << 1 = " << (x << 1) << endl; // 10 (1010 - Left Shift)
    cout << "x >> 1 = " << (x >> 1) << endl; // 2 (0010 - Right Shift)

    // Assignment
    int c = 15;
    c += 5; // c = c + 5; => 20
    cout << "c after += 5: " << c << endl;
    c *= 2; // c = c * 2; => 40
    cout << "c after *= 2: " << c << endl;

    // Ternary Operator
    int ternaryResult = (a > b) ? a : b; // If a > b, result is a, else b
    cout << "Max of a and b (ternary): " << ternaryResult << endl;
}

// ---===[ 4. Control Flow ]===---
void demonstrateControlFlow() {
    cout << "\n---===[ 4. Control Flow ]===---" << endl;
    int score = 75;

    // If-Else If-Else
    if (score >= 90) {
        cout << "Grade: A" << endl;
    } else if (score >= 80) {
        cout << "Grade: B" << endl;
    } else if (score >= 70) {
        cout << "Grade: C" << endl;
    } else {
        cout << "Grade: D/F" << endl;
    }

    // Switch (often used for discrete values)
    char grade = 'B';
    switch (grade) {
        case 'A':
            cout << "Excellent!" << endl;
            break; // Important! Exits the switch
        case 'B':
            cout << "Good job!" << endl;
            break;
        case 'C':
            cout << "Satisfactory." << endl;
            break;
        default:
            cout << "Needs improvement." << endl;
            break; // Optional for default if it's the last case
    }

    // While loop
    int count = 0;
    cout << "While loop: ";
    while (count < 3) {
        cout << count << " ";
        count++; // Increment counter
    }
    cout << endl;

    // Do-While loop (guaranteed to execute at least once)
    int countdown = 3;
    cout << "Do-While loop: ";
    do {
        cout << countdown << " ";
        countdown--;
    } while (countdown > 0);
    cout << endl;

    // For loop (traditional)
    cout << "For loop: ";
    for (int i = 0; i < 4; ++i) { // ++i is often slightly preferred over i++ in loops
        cout << i << " ";
    }
    cout << endl;

    // Range-based for loop (C++11) - requires a range (like STL container or array)
    vector<int> numbers = {10, 20, 30};
    cout << "Range-based for loop: ";
    for (int num : numbers) {
        cout << num << " ";
    }
    cout << endl;

    // Using range-based for with modification (use reference)
    cout << "Modified range-based for loop: ";
    for (int& num : numbers) {
        num *= 2; // Double each element
        cout << num << " ";
    }
    cout << endl;
}

// ---===[ 5. Functions ]===---
// Function Declaration (Prototype)
int add(int x, int y); // Declares the function signature

// Function Definition
void greet(const string& name) { // Pass string by const reference (efficient, prevents modification)
    cout << "Hello, " << name << "!" << endl;
}

// Pass by value (makes a copy)
void valueFunc(int val) {
    val = 100; // Modifies the copy, not the original
}

// Pass by reference (alias to the original)
void referenceFunc(int& ref) {
    ref = 200; // Modifies the original variable
}

// Pass by pointer (passes memory address)
void pointerFunc(int* ptr) {
    if (ptr != nullptr) { // Always check pointers before dereferencing! Use nullptr (C++11)
        *ptr = 300; // Modifies the original variable via the pointer
    }
}

// Function with default arguments
void showInfo(const string& msg, int level = 1) { // level defaults to 1
    cout << "[Level " << level << "] " << msg << endl;
}

// Function Overloading (same name, different parameters)
int multiply(int a, int b) {
    return a * b;
}

double multiply(double a, double b) {
    return a * b;
}

// Recursive Function (calls itself)
long long factorial(int n) {
    if (n < 0) return -1; // Error case
    if (n == 0 || n == 1) {
        return 1; // Base case
    } else {
        return n * factorial(n - 1); // Recursive step
    }
}

void demonstrateFunctions() {
    cout << "\n---===[ 5. Functions ]===---" << endl;

    greet("Alice");
    cout << "Sum 5 + 3 = " << add(5, 3) << endl;

    int originalVal = 10;
    cout << "Original value before calls: " << originalVal << endl;

    valueFunc(originalVal);
    cout << "After valueFunc: " << originalVal << endl; // Remains 10

    referenceFunc(originalVal);
    cout << "After referenceFunc: " << originalVal << endl; // Changes to 200

    pointerFunc(&originalVal); // Pass the address of originalVal
    cout << "After pointerFunc: " << originalVal << endl; // Changes to 300

    showInfo("This is a standard message.");
    showInfo("This is a high-level message.", 5);

    cout << "Multiply (int): 4 * 5 = " << multiply(4, 5) << endl;
    cout << "Multiply (double): 2.5 * 3.0 = " << multiply(2.5, 3.0) << endl;

    cout << "Factorial of 5: " << factorial(5) << endl; // 120
}

// Definition for the declared add function
int add(int x, int y) {
    return x + y;
}

// ---===[ 6. Pointers and References ]===---
// (Demonstrated partially in Functions section)
void demonstratePointersAndReferences() {
    cout << "\n---===[ 6. Pointers and References ]===---" << endl;

    int var = 50;
    int* ptr = &var;   // Pointer 'ptr' stores the memory address of 'var'
    int& ref = var;   // Reference 'ref' is an alias for 'var'

    cout << "Value of var: " << var << endl;
    cout << "Address of var (&var): " << &var << endl;
    cout << "Value of ptr (address of var): " << ptr << endl;
    cout << "Value pointed to by ptr (*ptr): " << *ptr << endl; // Dereferencing
    cout << "Value of ref: " << ref << endl;

    *ptr = 60; // Modify var through pointer
    cout << "Value of var after *ptr = 60: " << var << endl;

    ref = 70; // Modify var through reference
    cout << "Value of var after ref = 70: " << var << endl;

    // Dynamic Memory Allocation (Heap) - Use smart pointers where possible!
    int* heapInt = new int(100); // Allocate an int on the heap, initialize to 100
    if (heapInt) { // Check if allocation succeeded (though 'new' throws on failure usually)
        cout << "Dynamically allocated int: " << *heapInt << endl;
        *heapInt = 110;
        cout << "Modified heap int: " << *heapInt << endl;
        delete heapInt; // VERY IMPORTANT: Deallocate memory to prevent leaks
        heapInt = nullptr; // Good practice: Set pointer to null after delete
    }

    // Dynamic array
    int size = 5;
    int* heapArray = new int[size]; // Allocate an array of 5 ints on the heap
    for(int i=0; i<size; ++i) {
        heapArray[i] = i * 10;
    }
    cout << "Dynamically allocated array: ";
    for(int i=0; i<size; ++i) {
        cout << heapArray[i] << " ";
    }
    cout << endl;
    delete[] heapArray; // VERY IMPORTANT: Use delete[] for arrays
    heapArray = nullptr;
}

// ---===[ 7. Object-Oriented Programming (OOP) ]===---

// Abstract Base Class (contains at least one pure virtual function)
class Shape {
public:
    // Constructor
    Shape(const string& name) : name_(name) {
        cout << "Shape(" << name_ << ") created." << endl;
    }

    // Virtual Destructor: CRUCIAL for base classes with virtual functions
    // Ensures derived class destructors are called correctly via base pointers.
    virtual ~Shape() {
        cout << "Shape(" << name_ << ") destroyed." << endl;
    }

    // Pure Virtual Function (makes Shape abstract - cannot instantiate Shape directly)
    virtual double area() const = 0;

    // Regular Virtual Function (can be overridden by derived classes)
    virtual void display() const {
        cout << "Shape: " << name_;
    }

    // Public member function (getter) - Encapsulation
    string getName() const { return name_; }

protected: // Accessible by this class and derived classes
    string name_;

private: // Accessible only by this class (Encapsulation)
    // Example: internal ID, not used in this demo
    int shapeId_ = 0;
};

// Derived Class 1: Circle
class Circle : public Shape { // Public inheritance
public:
    // Constructor calling base class constructor
    Circle(const string& name, double radius) : Shape(name), radius_(radius) {
        cout << "Circle(" << name_ << ", radius=" << radius_ << ") created." << endl;
    }

    // Destructor (automatically virtual because base destructor is virtual)
    ~Circle() override { // 'override' keyword (C++11) checks if it actually overrides a base virtual function
        cout << "Circle(" << name_ << ") destroyed." << endl;
    }

    // Provide implementation for the pure virtual function
    double area() const override {
        return 3.1415926535 * radius_ * radius_; // Using the const PI would be better
    }

    // Override the display function
    void display() const override {
        Shape::display(); // Call base class version if needed
        cout << ", Type: Circle, Radius: " << radius_ << ", Area: " << area() << endl;
    }

    // Circle-specific method
    double getRadius() const { return radius_; }

private:
    double radius_;
};

// Derived Class 2: Rectangle
class Rectangle : public Shape {
public:
    Rectangle(const string& name, double width, double height)
        : Shape(name), width_(width), height_(height) {
        cout << "Rectangle(" << name_ << ", w=" << width_ << ", h=" << height_ << ") created." << endl;
    }

    ~Rectangle() override {
        cout << "Rectangle(" << name_ << ") destroyed." << endl;
    }

    double area() const override {
        return width_ * height_;
    }

    void display() const override {
        Shape::display();
        cout << ", Type: Rectangle, Width: " << width_ << ", Height: " << height_ << ", Area: " << area() << endl;
    }

private:
    double width_;
    double height_;
};

// Simple class demonstrating other constructor types (Copy/Move)
class ResourceHolder {
public:
    string name;
    int* data; // Example resource (raw pointer)

    // Default Constructor
    ResourceHolder(string n = "Default") : name(n), data(new int(0)) {
        cout << "ResourceHolder '" << name << "' Default Constructed." << endl;
    }

    // Parameterized Constructor
    ResourceHolder(string n, int val) : name(n), data(new int(val)) {
        cout << "ResourceHolder '" << name << "' Parameterized Constructed with value " << *data << "." << endl;
    }

    // Destructor (Rule of Three/Five/Zero: If you manage raw resources, you need copy/move/destructor)
    ~ResourceHolder() {
        cout << "ResourceHolder '" << name << "' Destructing. Deleting data: " << (data ? *data : -1) << "." << endl;
        delete data; // Release resource
        data = nullptr;
    }

    // Copy Constructor (Deep Copy) - Rule of Three/Five
    ResourceHolder(const ResourceHolder& other) : name(other.name + "_copy"), data(new int(*other.data)) {
        cout << "ResourceHolder '" << name << "' Copy Constructed from '" << other.name << "'." << endl;
    }

    // Copy Assignment Operator (Deep Copy) - Rule of Three/Five
    ResourceHolder& operator=(const ResourceHolder& other) {
        cout << "ResourceHolder '" << name << "' Copy Assigned from '" << other.name << "'." << endl;
        if (this != &other) { // Prevent self-assignment
            delete data; // Delete existing resource
            name = other.name + "_assigned";
            data = new int(*other.data); // Allocate and copy new resource
        }
        return *this;
    }

    // Move Constructor (C++11) - Rule of Five
    ResourceHolder(ResourceHolder&& other) noexcept // 'noexcept' is important for optimization
        : name(std::move(other.name)), data(other.data) // FIXED: Added std::
    {
        cout << "ResourceHolder Move Constructed, stealing resources from temporary/moved-from object." << endl;
        // Important: Leave the 'other' object in a valid (destructible) state
        other.data = nullptr; // Steal the pointer, nullify the source
        other.name += "_moved_from";
    }

    // Move Assignment Operator (C++11) - Rule of Five
    ResourceHolder& operator=(ResourceHolder&& other) noexcept {
        cout << "ResourceHolder Move Assigned, stealing resources from temporary/moved-from object." << endl;
        if (this != &other) {
            delete data; // Delete existing resource

            name = std::move(other.name); // FIXED: Added std:: // Move name
            data = other.data;       // Steal pointer

            // Leave 'other' in a valid state
            other.data = nullptr;
            other.name += "_moved_from";
        }
        return *this;
    }

    void print() const {
        if (data)
            cout << "ResourceHolder '" << name << "' holds data: " << *data << endl;
        else
            cout << "ResourceHolder '" << name << "' holds no data (nullptr)." << endl;
    }
};


void demonstrateOOP() {
    cout << "\n---===[ 7. Object-Oriented Programming (OOP) ]===---" << endl;

    // Cannot create instance of abstract class Shape
    // Shape myShape("Generic"); // Error!

    // Create derived objects
    Circle c1("MyCircle", 5.0);
    Rectangle r1("MyRect", 4.0, 6.0);

    c1.display();
    r1.display();

    cout << "\nPolymorphism Demo:" << endl;
    // Use base class pointers to point to derived objects
    Shape* shapePtr1 = &c1;
    Shape* shapePtr2 = &r1;

    // Call virtual functions through base pointers - executes the DERIVED version
    shapePtr1->display(); // Calls Circle::display()
    shapePtr2->display(); // Calls Rectangle::display()

    // Store shapes polymorphically (using smart pointers is better - see Memory section)
    vector<unique_ptr<Shape>> shapeCollection; // Use smart pointers for safety!
    shapeCollection.push_back(make_unique<Circle>("SmartCircle", 3.0)); // C++14 needed
    shapeCollection.push_back(make_unique<Rectangle>("SmartRect", 2.0, 5.0)); // C++14 needed
    // Note: Cannot easily add c1 and r1 (stack objects) to a vector of unique_ptr owning heap objects.
    // We'll use dynamically allocated ones here.

    cout << "\nIterating through polymorphic collection (using unique_ptr):" << endl;
    for (const auto& shapePtr : shapeCollection) { // Use const auto&
        shapePtr->display(); // Correct derived version is called via smart pointer
    }
    // No manual delete needed! unique_ptr handles cleanup when vector goes out of scope.


    cout << "\nCopy/Move Semantics Demo:" << endl;
    ResourceHolder rh1("Obj1", 10);
    ResourceHolder rh2("Obj2", 20);

    ResourceHolder rh3 = rh1; // Copy constructor
    rh3.print();

    rh2 = rh1; // Copy assignment operator
    rh2.print();

    ResourceHolder rh4 = std::move(rh1); // FIXED: Added std:: // Move constructor (rh1 is now likely unusable/empty)
    rh4.print();
    rh1.print(); // rh1 state after move

    ResourceHolder rh5("Obj5", 50);
    rh5 = std::move(rh2); // FIXED: Added std:: // Move assignment operator (rh2 is now likely unusable/empty)
    rh5.print();
    rh2.print(); // rh2 state after move
    // All ResourceHolders will be automatically destructed when they go out of scope here.
}


// ---===[ 8. Templates ]===---

// Function Template: Works with different data types
template <typename T> // 'typename' or 'class' can be used here
T findMax(T a, T b) {
    return (a > b) ? a : b;
}

// Class Template: A blueprint for generating classes based on type parameters
template <typename T1, typename T2>
class Pair {
public:
    Pair(T1 first, T2 second) : first_(first), second_(second) {}

    void display() const {
        cout << "Pair: (" << first_ << ", " << second_ << ")" << endl;
    }

    T1 getFirst() const { return first_; }
    T2 getSecond() const { return second_; }

private:
    T1 first_;
    T2 second_;
};

void demonstrateTemplates() {
    cout << "\n---===[ 8. Templates ]===---" << endl;

    // Using the function template
    cout << "Max of 5, 10 (int): " << findMax(5, 10) << endl;
    cout << "Max of 3.14, 2.71 (double): " << findMax(3.14, 2.71) << endl;
    cout << "Max of 'hello', 'world' (string): " << findMax(string("hello"), string("world")) << endl;

    // Instantiating the class template
    Pair<int, string> p1(1, "Apple");
    Pair<string, double> p2("Pi", 3.14159);

    p1.display();
    p2.display();
    cout << "First element of p1: " << p1.getFirst() << endl;
}

// ---===[ 9. Standard Template Library (STL) ]===---
void demonstrateSTL() {
    cout << "\n---===[ 9. Standard Template Library (STL) ]===---" << endl;

    // --- Vector (Dynamic Array) ---
    cout << "--- Vector ---" << endl;
    vector<int> numbers; // Create an empty vector of ints
    numbers.push_back(30); // Add element to the end
    numbers.push_back(10);
    numbers.push_back(20);
    cout << "Vector size: " << numbers.size() << endl;
    cout << "Vector elements: ";
    for (int num : numbers) { // Range-based for loop
        cout << num << " ";
    }
    cout << endl;

    // Access elements
    cout << "Element at index 1: " << numbers[1] << endl;       // Direct access (no bounds check)
    cout << "Element at index 0: " << numbers.at(0) << endl;    // Access with bounds check (throws exception if out of range)

    // --- Iterators ---
    cout << "Iterating with iterators: ";
    vector<int>::iterator it; // Declare an iterator
    for (it = numbers.begin(); it != numbers.end(); ++it) {
        cout << *it << " "; // Dereference iterator to get value
    }
    cout << endl;

    // --- Algorithms ---
    sort(numbers.begin(), numbers.end()); // Sort the vector
    cout << "Sorted vector: ";
    for (int num : numbers) { cout << num << " "; }
    cout << endl;

    // --- String ---
    cout << "\n--- String ---" << endl;
    string message = "Hello, C++ STL!";
    cout << "Original string: " << message << endl;
    cout << "Length: " << message.length() << endl; // or message.size()
    message += " It's powerful."; // Concatenation
    cout << "Appended string: " << message << endl;
    size_t pos = message.find("STL"); // Find substring
    if (pos != string::npos) { // npos means 'not found'
        cout << "'STL' found at position: " << pos << endl;
    }

    // --- Map (Key-Value Associative Container) ---
    cout << "\n--- Map ---" << endl;
    map<string, int> ages; // Map from string (name) to int (age)
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    ages["Charlie"] = 35;
    ages.insert(make_pair("David", 28)); // Another way to insert (C++11)
    // ages.insert({"Eve", 22}); // Alternative using initializer list (C++11)
    // ages.emplace("Frank", 40); // More efficient insertion (C++11)

    cout << "Bob's age: " << ages["Bob"] << endl;
    // Check if key exists before accessing (safer than operator[])
    if (ages.count("Eve")) {
        cout << "Eve's age: " << ages["Eve"] << endl;
    } else {
        cout << "Eve not found in map." << endl;
    }

    // Iterate through map
    cout << "Map contents:" << endl;
    for (const auto& pair : ages) { // Use auto& for efficiency
        cout << pair.first << ": " << pair.second << endl;
    }
}

// ---===[ 10. Exception Handling ]===---
double divide(double numerator, double denominator) {
    if (abs(denominator) < 1e-9) { // Check for division by zero (handle floating point carefully)
        throw runtime_error("Division by zero error!"); // Throw an exception object
    }
    return numerator / denominator;
}

void demonstrateExceptions() {
    cout << "\n---===[ 10. Exception Handling ]===---" << endl;

    try {
        double result1 = divide(10.0, 2.0);
        cout << "10.0 / 2.0 = " << result1 << endl;

        cout << "Attempting division by zero..." << endl;
        double result2 = divide(5.0, 0.0); // This will throw
        cout << "This line will not be reached." << endl; // Execution jumps to catch block

    } catch (const runtime_error& e) { // Catch specific standard exception by const reference
        cerr << "Caught an exception: " << e.what() << endl; // cerr is standard error stream
    } catch (const exception& e) { // Catch other standard exceptions (base class)
        cerr << "Caught a general std::exception: " << e.what() << endl;
    } catch (...) { // Catch-all (use sparingly)
        cerr << "Caught an unknown exception!" << endl;
    }

    cout << "Exception handling demo finished." << endl;
}


// ---===[ 11. Memory Management (Smart Pointers) ]===---
// Re-using ResourceHolder class from OOP section
void demonstrateMemoryManagement() {
    cout << "\n---===[ 11. Memory Management (Smart Pointers) ]===---" << endl;

    // unique_ptr: Exclusive ownership. Automatically deletes the managed object
    // when the unique_ptr goes out of scope. Cannot be copied, only moved.
    cout << "--- unique_ptr ---" << endl;
    { // Inner scope to show automatic destruction
        // Use make_unique (requires C++14) - preferred way
        unique_ptr<ResourceHolder> uPtr1 = make_unique<ResourceHolder>("UniqueObj1", 100);
        uPtr1->print();

        // unique_ptr<ResourceHolder> uPtrCopy = uPtr1; // Error: Cannot copy unique_ptr
        unique_ptr<ResourceHolder> uPtrMoved = std::move(uPtr1); // FIXED: Added std:: // Move ownership

        cout << "Ownership moved." << endl;
        uPtrMoved->print();
        if (!uPtr1) { // Check if uPtr1 is now null after move
            cout << "uPtr1 is now null." << endl;
        }
        // uPtrMoved will be automatically destroyed at the end of this scope
        cout << "End of unique_ptr scope." << endl;
    } // uPtrMoved's ResourceHolder is destructed here


    // shared_ptr: Shared ownership. Keeps a reference count. The managed object
    // is deleted only when the last shared_ptr pointing to it goes out of scope or is reset.
    cout << "\n--- shared_ptr ---" << endl;
    shared_ptr<ResourceHolder> sPtr1; // Starts as null
    { // Inner scope
        shared_ptr<ResourceHolder> sPtr2 = make_shared<ResourceHolder>("SharedObj1", 200); // Preferred way (C++11 onwards)
        cout << "sPtr2 use count: " << sPtr2.use_count() << endl; // Count = 1

        sPtr1 = sPtr2; // Copying shared_ptr increases reference count
        cout << "sPtr1 assigned from sPtr2." << endl;
        cout << "sPtr1 use count: " << sPtr1.use_count() << endl; // Count = 2
        cout << "sPtr2 use count: " << sPtr2.use_count() << endl; // Count = 2

        sPtr1->print();
        sPtr2->print();

        cout << "End of shared_ptr inner scope." << endl;
    } // sPtr2 goes out of scope, reference count decreases to 1. Object NOT deleted yet.

    cout << "After inner scope." << endl;
    cout << "sPtr1 use count: " << sPtr1.use_count() << endl; // Count = 1
    sPtr1->print();
    // sPtr1 goes out of scope at the end of the function, count becomes 0, object deleted.
    cout << "End of demonstrateMemoryManagement function." << endl;
} // sPtr1's ResourceHolder is destructed here


// ---===[ 12. Modern C++ Features (Briefly) ]===---
void demonstrateModernFeatures() {
    cout << "\n---===[ 12. Modern C++ Features (Briefly) ]===---" << endl;

    // nullptr (C++11): Type-safe null pointer constant
    int* legacyNull = NULL; // Older C-style null (often just 0)
    int* modernNull = nullptr; // Preferred, safer null pointer
    // pointerFunc(NULL); // Works, but less safe
    pointerFunc(nullptr); // Better

    if (modernNull == nullptr) {
        cout << "modernNull is indeed nullptr." << endl;
    }

    // Lambda Expressions (C++11): Anonymous functions
    vector<int> data = {1, 2, 3, 4, 5, 6};
    cout << "Original data: ";
    for(int d : data) cout << d << " ";
    cout << endl;

    // Simple lambda to print squares (using <algorithm> for_each)
    cout << "Squares: ";
    for_each(data.begin(), data.end(), [](int n){ cout << (n * n) << " "; });
    cout << endl;

    // Lambda with capture (capturing variables from the surrounding scope)
    // Using <algorithm> count_if
    int threshold = 3;
    int count_above_threshold = count_if(data.begin(), data.end(),
        [threshold](int n){ return n > threshold; } // Captures 'threshold' by value
    );
    cout << "Count above threshold (" << threshold << "): " << count_above_threshold << endl;

    // Lambda capturing by reference
    int sum = 0;
    for_each(data.begin(), data.end(),
        [&sum](int n){ sum += n; } // Captures 'sum' by reference
    );
    cout << "Sum of elements (calculated by lambda): " << sum << endl;

    // Range-based for loops (already used extensively above)
    // auto keyword (already used above)
}

// ---===[ 13. File I/O ]===---
void demonstrateFileIO() {
    cout << "\n---===[ 13. File I/O ]===---" << endl;
    const string filename = "cpp_demo_file.txt";

    // --- Writing to a file ---
    // ofstream (output file stream). Constructor opens the file.
    // std::ios::out is default mode (overwrite). Use std::ios::app to append.
    ofstream outFile(filename);

    if (outFile.is_open()) { // Always check if the file opened successfully
        cout << "Writing to file: " << filename << endl;
        outFile << "This is line 1 written from the C++ demo.\n";
        outFile << "Demonstrating basic file output.\n";
        outFile << "Value: " << 123 << ", Float: " << 45.67 << endl;
        outFile.close(); // Good practice, though destructor closes it automatically
        cout << "Finished writing." << endl;
    } else {
        cerr << "Error: Unable to open file " << filename << " for writing." << endl;
    }

    // --- Reading from a file ---
    // ifstream (input file stream)
    ifstream inFile(filename);
    if (inFile.is_open()) {
        cout << "\nReading from file: " << filename << endl;
        string line;
        // Read file line by line
        while (getline(inFile, line)) { // getline reads until newline
            cout << "Read line: " << line << endl;
        }
        inFile.close(); // Good practice
        cout << "Finished reading." << endl;
    } else {
        cerr << "Error: Unable to open file " << filename << " for reading." << endl;
    }
}


// ---===[ Main Function: Program Entry Point ]===---
int main() {
    cout << "====== Comprehensive C++ Demonstration (C++14 Required) ======" << endl;

    // Call functions demonstrating different aspects
    demonstrateDataTypes();
    demonstrateOperators();
    demonstrateControlFlow();
    demonstrateFunctions();
    demonstratePointersAndReferences();
    demonstrateOOP(); // Includes constructors, destructors, inheritance, polymorphism
    demonstrateTemplates();
    demonstrateSTL(); // Includes containers, iterators, algorithms
    demonstrateExceptions();
    demonstrateMemoryManagement(); // Focuses on smart pointers
    demonstrateModernFeatures(); // Lambdas, nullptr etc.
    demonstrateFileIO();

    cout << "\n====== Demonstration Complete ======" << endl;

    return 0; // Indicate successful execution
}