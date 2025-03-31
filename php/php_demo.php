<?php

/**
 * PHP Comprehensive Syntax and Feature Demonstration
 *
 * This file aims to showcase a wide variety of PHP language features.
 * It's designed to be run (preferably via CLI or a web server) and studied.
 * Note: This is for demonstration; real-world applications should be structured differently.
 */

// Set error reporting for demonstration purposes (show everything)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// For better readability in web browsers if run via a server
if (php_sapi_name() !== 'cli') {
    header('Content-Type: text/plain'); // Output as plain text
}

echo "========================================\n";
echo " PHP Comprehensive Demonstration Start \n";
echo "========================================\n\n";

// --- 1. Basic Syntax: Output, Comments, Tags ---

echo "--- 1. Basic Syntax ---\n";

// This is a single-line comment
# This is also a single-line comment (less common)

/*
This is a
multi-line
comment block.
*/

echo "Hello, World!\n"; // Basic output statement
print "Another way to output.\n"; // Alternative output (slightly different, behaves like a function)

// PHP code is typically enclosed in <?php ... ?> tags.
// If a file contains *only* PHP code, the closing tag ?> is best omitted.


// --- 2. Variables and Data Types ---

echo "\n--- 2. Variables and Data Types ---\n";

$message = "This is a string variable."; // String
$count = 10;                            // Integer
$price = 19.99;                         // Float (or double)
$isAvailable = true;                    // Boolean
$nothing = null;                        // Null (represents no value)

echo "String: " . $message . "\n"; // String concatenation using '.'
echo "Integer: $count\n";          // Variables can be embedded in double-quoted strings
echo 'Float: $price' . "\n";       // Variables are NOT embedded in single-quoted strings
echo "Boolean: " . ($isAvailable ? 'true' : 'false') . "\n"; // Outputting boolean
echo "Null: " . var_export($nothing, true) . "\n"; // var_export gives a parsable representation

// Arrays
$simpleArray = [1, 2, 3, "apple", true]; // Simple indexed array (modern syntax)
$assocArray = [                         // Associative array (key-value pairs)
    "name" => "Alice",
    "age" => 30,
    "city" => "New York"
];

echo "Simple Array Element: " . $simpleArray[3] . "\n";
echo "Associative Array Element: " . $assocArray["name"] . "\n";

print_r($simpleArray); // print_r is useful for displaying array contents
var_dump($assocArray); // var_dump provides detailed info including types

// Constants
define("SITE_NAME", "My Awesome Site"); // Older way to define constants
const APP_VERSION = "1.0.0";           // Modern way (preferred, especially in classes)

echo "Constant SITE_NAME: " . SITE_NAME . "\n";
echo "Constant APP_VERSION: " . APP_VERSION . "\n";

// Type Hinting & Checking (more relevant in functions/methods)
echo "Type of \$count: " . gettype($count) . "\n";
echo "Is \$price a float? " . (is_float($price) ? 'Yes' : 'No') . "\n";


// --- 3. Operators ---

echo "\n--- 3. Operators ---\n";

$a = 10;
$b = 4;

// Arithmetic
echo "Arithmetic:\n";
echo "$a + $b = " . ($a + $b) . "\n";
echo "$a - $b = " . ($a - $b) . "\n";
echo "$a * $b = " . ($a * $b) . "\n";
echo "$a / $b = " . ($a / $b) . "\n";
echo "$a % $b = " . ($a % $b) . " (Modulo/Remainder)\n";
echo "$a ** $b = " . ($a ** $b) . " (Exponentiation)\n";

// Assignment
echo "\nAssignment:\n";
$c = 5;
$c += 3; // $c is now 8 ($c = $c + 3)
echo "c += 3: $c\n";
$message .= " More text."; // String concatenation assignment
echo "Message: $message\n";

// Comparison (== vs ===)
echo "\nComparison:\n";
$numStr = "10";
echo "$a == $numStr: " . ($a == $numStr ? 'true' : 'false') . " (Loose comparison, type coercion)\n";
echo "$a === $numStr: " . ($a === $numStr ? 'true' : 'false') . " (Strict comparison, type and value)\n";
echo "$a != $b: " . ($a != $b ? 'true' : 'false') . "\n";
echo "$a !== $numStr: " . ($a !== $numStr ? 'true' : 'false') . "\n";
echo "$a > $b: " . ($a > $b ? 'true' : 'false') . "\n";

// Logical
echo "\nLogical:\n";
$isMember = true;
$hasDiscount = false;
echo "\$isMember && \$hasDiscount: " . ($isMember && $hasDiscount ? 'true' : 'false') . " (AND)\n";
echo "\$isMember || \$hasDiscount: " . ($isMember || $hasDiscount ? 'true' : 'false') . " (OR)\n";
echo "!\$hasDiscount: " . (!$hasDiscount ? 'true' : 'false') . " (NOT)\n";

// Increment/Decrement
echo "\nIncrement/Decrement:\n";
$counter = 5;
echo "Initial counter: $counter\n";
echo "Post-increment (counter++): " . $counter++ . " (Value before increment)\n";
echo "After post-increment: $counter\n";
echo "Pre-increment (++counter): " . ++$counter . " (Value after increment)\n";
echo "After pre-increment: $counter\n";
// Similar for --

// Ternary Operator
echo "\nTernary Operator:\n";
$userStatus = $isMember ? "Logged In" : "Guest";
echo "User Status: $userStatus\n";

// Null Coalescing Operator (PHP 7+)
echo "\nNull Coalescing Operator (??):\n";
$username = $_GET['user'] ?? 'default_user'; // Use 'default_user' if $_GET['user'] is not set or null
echo "Username: $username (Try adding ?user=test to the URL if on web)\n";
$configValue = $settings['color'] ?? $globalDefaults['color'] ?? 'blue'; // Chaining
// echo "Config Value: $configValue\n"; // Needs $settings/$globalDefaults defined

// Spaceship Operator (PHP 7+)
echo "\nSpaceship Operator (<=>):\n";
$x = 10; $y = 20;
echo "$x <=> $y: " . ($x <=> $y) . " (-1 if left is less, 0 if equal, 1 if left is greater)\n";
echo "$y <=> $x: " . ($y <=> $x) . "\n";
echo "$x <=> $x: " . ($x <=> $x) . "\n";


// --- 4. Control Structures ---

echo "\n--- 4. Control Structures ---\n";

// If/Elseif/Else
echo "\nIf/Elseif/Else:\n";
$score = 75;
if ($score >= 90) {
    echo "Grade: A\n";
} elseif ($score >= 80) {
    echo "Grade: B\n";
} elseif ($score >= 70) {
    echo "Grade: C\n";
} else {
    echo "Grade: D or F\n";
}

// Switch
echo "\nSwitch:\n";
$day = "Monday";
switch ($day) {
    case "Monday":
        echo "Start of the week.\n";
        break; // Important! Exit the switch
    case "Friday":
        echo "Almost weekend!\n";
        break;
    default:
        echo "It's some other day.\n";
        // No break needed for default if it's the last case
}

// For Loop
echo "\nFor Loop:\n";
for ($i = 0; $i < 5; $i++) {
    echo "Iteration: $i\n";
}

// While Loop
echo "\nWhile Loop:\n";
$j = 0;
while ($j < 3) {
    echo "While count: $j\n";
    $j++;
}

// Do...While Loop (guaranteed to run at least once)
echo "\nDo...While Loop:\n";
$k = 5;
do {
    echo "Do-While count: $k (runs once even if condition is false initially)\n";
    $k++;
} while ($k < 3);

// Foreach Loop (for arrays and objects)
echo "\nForeach Loop (Indexed Array):\n";
$colors = ["Red", "Green", "Blue"];
foreach ($colors as $index => $color) {
    echo "Index $index: $color\n";
}

echo "\nForeach Loop (Associative Array):\n";
foreach ($assocArray as $key => $value) {
    echo "$key: $value\n";
}

// Foreach without key
echo "\nForeach Loop (Values Only):\n";
foreach ($colors as $color) {
    echo "Color: $color\n";
}

// Break and Continue
echo "\nBreak and Continue in Loop:\n";
for ($i = 0; $i < 10; $i++) {
    if ($i == 3) {
        continue; // Skip iteration 3
    }
    if ($i == 7) {
        break; // Exit loop when $i hits 7
    }
    echo "Loop with break/continue: $i\n";
}


// --- 5. Functions ---

echo "\n--- 5. Functions ---\n";

// Basic Function Definition
function greet($name) {
    echo "Hello, $name!\n";
}
greet("Bob"); // Calling the function

// Function with Return Value and Type Hinting (PHP 7+)
function add(int $num1, int $num2): int {
    return $num1 + $num2;
}
$sum = add(5, 7);
echo "Sum from function: $sum\n";
// add("a", "b"); // This would cause a TypeError in PHP 7+ due to scalar type hints

// Function with Default Parameter Value
function power(int $base, int $exponent = 2): int {
    return $base ** $exponent;
}
echo "Default power (5^2): " . power(5) . "\n";
echo "Specific power (3^4): " . power(3, 4) . "\n";

// Variable Scope
$globalVar = "I am global";

function scopeTest() {
    $localVar = "I am local";
    echo "Inside function: " . $localVar . "\n";
    // echo $globalVar; // This would cause a notice (undefined variable) without 'global' keyword

    global $globalVar; // Accessing global variable (generally discouraged, pass as argument instead)
    echo "Inside function (global): " . $globalVar . "\n";

    // Accessing global via $GLOBALS array (alternative)
    echo "Inside function (\$GLOBALS): " . $GLOBALS['globalVar'] . "\n";
}
scopeTest();
echo "Outside function: " . $globalVar . "\n";
// echo $localVar; // This would cause an error (undefined variable)

// Static Variables within Functions
function staticCounter() {
    static $count = 0; // Initialized only once
    $count++;
    echo "Static counter: $count\n";
}
staticCounter();
staticCounter();
staticCounter();

// Anonymous Functions (Closures)
$sayHi = function($name) {
    echo "Hi there, $name!\n";
}; // Note the semicolon here
$sayHi("Charlie");

// Closures can inherit variables from the parent scope using `use`
$modifier = "!!!";
$emphasize = function($text) use ($modifier) {
    echo $text . $modifier . "\n";
};
emphasize("Important message");

// Arrow Functions (PHP 7.4+) - Concise syntax for simple closures
$multiply = fn($a, $b) => $a * $b;
echo "Arrow function (5 * 6): " . $multiply(5, 6) . "\n";

// Recursion (Function calling itself)
function factorial(int $n): int {
    if ($n < 0) {
        // Not typically defined for negative numbers, handle error or return specific value
        trigger_error("Factorial not defined for negative numbers", E_USER_WARNING);
        return 0;
    }
    if ($n <= 1) {
        return 1; // Base case
    } else {
        return $n * factorial($n - 1); // Recursive step
    }
}
echo "Factorial of 5: " . factorial(5) . "\n";


// --- 6. Object-Oriented Programming (OOP) ---

echo "\n--- 6. Object-Oriented Programming (OOP) ---\n";

// Basic Class Definition
class Vehicle {
    // Properties (member variables) with visibility modifiers
    public string $color;
    protected int $wheels; // Accessible within the class and child classes
    private int $speed = 0;   // Accessible only within this class

    // Constructor (called when creating an object)
    public function __construct(string $color, int $wheels = 4) {
        $this->color = $color;
        $this->wheels = $wheels;
        echo "Vehicle created. Color: {$this->color}, Wheels: {$this->wheels}\n";
    }

    // Methods (member functions)
    public function accelerate(int $increment): void { // void return type (PHP 7.1+)
        $this->speed += $increment;
        echo "Accelerating. Current speed: {$this->getSpeed()} km/h\n";
    }

    public function brake(int $decrement): void {
        $this->speed -= $decrement;
        if ($this->speed < 0) {
            $this->speed = 0;
        }
        echo "Braking. Current speed: {$this->getSpeed()} km/h\n";
    }

    // Getter method to access private property
    public function getSpeed(): int {
        return $this->speed;
    }

    // Destructor (called when object is destroyed or script ends)
    public function __destruct() {
        echo "Vehicle object destroyed.\n";
    }

    // Static property and method (belong to the class, not an instance)
    public static int $objectCount = 0;
    public static function showObjectCount(): void {
        echo "Total Vehicle objects created (tracked manually): " . self::$objectCount . "\n"; // Use self:: for static members
    }

    // Class Constant
    const DEFAULT_COUNTRY = "Unknown";
}

// Instantiating (Creating Objects)
$car1 = new Vehicle("Red"); // Uses default 4 wheels
Vehicle::$objectCount++; // Manually track (better ways exist)
$car2 = new Vehicle("Blue", 4);
Vehicle::$objectCount++;
$motorcycle = new Vehicle("Black", 2);
Vehicle::$objectCount++;

// Accessing properties and methods
$car1->color = "Bright Red"; // Access public property
echo "Car 1 color: " . $car1->color . "\n";
// echo $car1->wheels; // Fatal error: Cannot access protected property
// echo $car1->speed; // Fatal error: Cannot access private property

$car1->accelerate(50);
$car1->brake(20);
echo "Car 1 final speed: " . $car1->getSpeed() . " km/h\n";

// Accessing static members
Vehicle::showObjectCount();
echo "Default country: " . Vehicle::DEFAULT_COUNTRY . "\n";


// Inheritance
echo "\nInheritance:\n";
class Car extends Vehicle { // Car inherits from Vehicle
    public string $model;
    private bool $trunkOpen = false;

    // Override constructor (can call parent constructor)
    public function __construct(string $color, string $model) {
        parent::__construct($color, 4); // Call parent constructor
        $this->model = $model;
        echo "Car object created. Model: {$this->model}\n";
    }

    // Override method
    public function accelerate(int $increment): void {
        echo "Car {$this->model} is accelerating...\n";
        parent::accelerate($increment); // Call parent method
    }

    // New method specific to Car
    public function openTrunk(): void {
        $this->trunkOpen = true;
        echo "Trunk is now open.\n";
    }

    // Accessing protected property from parent
    public function getWheelCount(): int {
        return $this->wheels; // Protected property is accessible here
    }
}

$myCar = new Car("Silver", "Sedan");
Vehicle::$objectCount++;
$myCar->accelerate(70);
$myCar->openTrunk();
echo "My car has " . $myCar->getWheelCount() . " wheels.\n";

// Abstract Classes and Methods (Cannot be instantiated, enforce structure)
echo "\nAbstract Classes:\n";
abstract class Shape {
    protected string $name;

    public function __construct(string $name) {
        $this->name = $name;
    }

    public function getName(): string {
        return $this->name;
    }

    // Abstract method: Must be implemented by child classes
    abstract public function calculateArea(): float;
}

class Circle extends Shape {
    private float $radius;

    public function __construct(float $radius) {
        parent::__construct("Circle");
        $this->radius = $radius;
    }

    // Implementing the abstract method
    public function calculateArea(): float {
        return pi() * ($this->radius ** 2);
    }
}

// $shape = new Shape("Generic"); // Fatal error: Cannot instantiate abstract class Shape
$circle = new Circle(5);
echo "Shape: " . $circle->getName() . ", Area: " . $circle->calculateArea() . "\n";


// Interfaces (Define a contract for methods a class must implement)
echo "\nInterfaces:\n";
interface Loggable {
    public function log(string $message): void;
}

interface Editable {
    public function save(): bool;
    public function load(int $id): bool;
}

// Class implementing multiple interfaces
class User implements Loggable, Editable {
    private int $userId;
    private string $username;

    public function log(string $message): void {
        echo "User Log: [{$this->username}] - $message\n";
    }

    public function save(): bool {
        echo "Saving user {$this->username}...\n";
        // Database saving logic would go here
        $this->log("User saved.");
        return true;
    }

    public function load(int $id): bool {
        $this->userId = $id;
        // Database loading logic...
        $this->username = "LoadedUser" . $id; // Simulate loading
        echo "Loading user ID $id...\n";
        $this->log("User loaded.");
        return true;
    }
}

$user = new User();
$user->load(123);
$user->save();


// Traits (Code reuse mechanism, "horizontal inheritance")
echo "\nTraits:\n";
trait Timestampable {
    private ?DateTime $createdAt = null; // Nullable types (PHP 7.1+)
    private ?DateTime $updatedAt = null;

    public function setTimestamps(): void {
        $now = new DateTime();
        if ($this->createdAt === null) {
            $this->createdAt = $now;
        }
        $this->updatedAt = $now;
        echo "Timestamps set/updated.\n";
    }

    public function getCreatedAt(): ?DateTime {
        return $this->createdAt;
    }

    public function getUpdatedAt(): ?DateTime {
        return $this->updatedAt;
    }
}

class Document {
    use Timestampable; // Include the trait's methods and properties

    public string $title;

    public function __construct(string $title) {
        $this->title = $title;
        $this->setTimestamps(); // Call trait method
    }

    public function updateContent(string $content): void {
        echo "Updating document '{$this->title}'...\n";
        // Update logic...
        $this->setTimestamps(); // Update timestamp on change
    }
}

$doc = new Document("My Report");
sleep(1); // Pause for 1 second to see timestamp difference
$doc->updateContent("New content added.");

echo "Document '{$doc->title}' Created At: " . ($doc->getCreatedAt() ? $doc->getCreatedAt()->format('Y-m-d H:i:s') : 'N/A') . "\n";
echo "Document '{$doc->title}' Updated At: " . ($doc->getUpdatedAt() ? $doc->getUpdatedAt()->format('Y-m-d H:i:s') : 'N/A') . "\n";


// Magic Methods (methods with special names like __construct, __destruct, __get, __set, __call, __toString)
echo "\nMagic Methods:\n";
class MagicBox {
    private array $data = [];

    // __set is called when writing data to inaccessible (protected or private) or non-existing properties.
    public function __set(string $name, $value): void {
        echo "__set called for property '$name'\n";
        $this->data[$name] = $value;
    }

    // __get is called when reading data from inaccessible or non-existing properties.
    public function __get(string $name) {
        echo "__get called for property '$name'\n";
        return $this->data[$name] ?? null; // Return null if not set
    }

    // __isset is triggered by calling isset() or empty() on inaccessible or non-existing properties.
    public function __isset(string $name): bool {
        echo "__isset called for property '$name'\n";
        return isset($this->data[$name]);
    }

    // __unset is invoked when unset() is used on inaccessible or non-existing properties.
    public function __unset(string $name): void {
        echo "__unset called for property '$name'\n";
        unset($this->data[$name]);
    }

    // __call is triggered when invoking inaccessible methods in an object context.
    public function __call(string $name, array $arguments): void {
        echo "__call called for method '$name' with arguments: " . implode(', ', $arguments) . "\n";
    }

    // __toString is called when an object is treated as a string.
    public function __toString(): string {
        return "MagicBox instance containing: " . json_encode($this->data);
    }
}

$magic = new MagicBox();
$magic->secret = "Top Secret Value"; // Calls __set
$magic->count = 5;                 // Calls __set

echo "Secret value: " . $magic->secret . "\n"; // Calls __get
echo "Is count set? " . (isset($magic->count) ? 'Yes' : 'No') . "\n"; // Calls __isset

$magic->nonExistentMethod(1, 'abc'); // Calls __call

echo "Magic Box as string: " . $magic . "\n"; // Calls __toString

unset($magic->count); // Calls __unset
echo "Is count set after unset? " . (isset($magic->count) ? 'Yes' : 'No') . "\n"; // Calls __isset


// --- 7. Error and Exception Handling ---

echo "\n--- 7. Error and Exception Handling ---\n";

// Basic Try-Catch
function divide(int $a, int $b): float {
    if ($b == 0) {
        throw new Exception("Division by zero is not allowed!"); // Throw an exception
    }
    return $a / $b;
}

try {
    $result = divide(10, 2);
    echo "Division result (10/2): $result\n";

    $result = divide(5, 0); // This will throw an exception
    echo "This line won't be reached.\n";

} catch (Exception $e) { // Catch the specific exception
    echo "Caught Exception: " . $e->getMessage() . "\n";
    // echo "Trace: " . $e->getTraceAsString() . "\n"; // Get detailed trace
} finally {
    // This block always executes, whether an exception occurred or not
    echo "Finally block executed.\n";
}

// Custom Exceptions
class NetworkException extends Exception {}
class AuthenticationException extends Exception {}

function simulateNetworkOperation(bool $fail) {
    if ($fail) {
        throw new NetworkException("Network connection failed.");
    }
    echo "Network operation successful.\n";
}

try {
    simulateNetworkOperation(false);
    simulateNetworkOperation(true);
} catch (NetworkException $ne) {
    echo "Caught Network Exception: " . $ne->getMessage() . "\n";
} catch (AuthenticationException $ae) {
    echo "Caught Authentication Exception: " . $ae->getMessage() . "\n";
} catch (Exception $e) {
    // Catch any other general exceptions
    echo "Caught General Exception: " . $e->getMessage() . "\n";
}


// --- 8. File Handling ---

echo "\n--- 8. File Handling ---\n";

$filename = "php_demo_file.txt";

// Writing to a file (file_put_contents is often simpler)
$contentToWrite = "This is line 1.\nThis is line 2.\n";
if (file_put_contents($filename, $contentToWrite) !== false) {
    echo "Successfully wrote to '$filename'.\n";
} else {
    echo "Error writing to '$filename'. Check permissions.\n";
}

// Appending to a file
if (file_put_contents($filename, "This is line 3 (appended).\n", FILE_APPEND) !== false) {
    echo "Successfully appended to '$filename'.\n";
} else {
    echo "Error appending to '$filename'.\n";
}

// Reading from a file (file_get_contents is often simpler)
if (file_exists($filename)) {
    $contentRead = file_get_contents($filename);
    if ($contentRead !== false) {
        echo "Content read from '$filename':\n---\n" . $contentRead . "---\n";
    } else {
        echo "Error reading from '$filename'.\n";
    }

    // Reading line by line using fopen/fgets
    echo "Reading line by line:\n";
    $handle = fopen($filename, "r"); // Open for reading ('r')
    if ($handle) {
        while (($line = fgets($handle)) !== false) {
            echo "Line: " . rtrim($line) . "\n"; // rtrim to remove trailing newline
        }
        fclose($handle); // Close the file handle
        echo "Finished reading line by line.\n";
    } else {
        echo "Error opening '$filename' for line-by-line reading.\n";
    }

    // Deleting the file
    // if (unlink($filename)) {
    //     echo "Successfully deleted '$filename'.\n";
    // } else {
    //     echo "Error deleting '$filename'.\n";
    // }

} else {
    echo "File '$filename' does not exist for reading.\n";
}


// --- 9. JSON Handling ---

echo "\n--- 9. JSON Handling ---\n";

$dataArray = [
    "name" => "Example User",
    "id" => 987,
    "roles" => ["admin", "editor"],
    "active" => true
];

// Encoding PHP array to JSON string
$jsonString = json_encode($dataArray, JSON_PRETTY_PRINT); // Pretty print for readability
echo "PHP Array encoded to JSON:\n" . $jsonString . "\n";

// Decoding JSON string back to PHP (true for associative array, false/omitted for stdClass object)
$decodedArray = json_decode($jsonString, true);
$decodedObject = json_decode($jsonString);

echo "\nJSON decoded back to PHP Array:\n";
print_r($decodedArray);
echo "Accessing element from decoded array: " . $decodedArray['roles'][0] . "\n";

echo "\nJSON decoded back to PHP Object (stdClass):\n";
print_r($decodedObject);
echo "Accessing element from decoded object: " . $decodedObject->roles[1] . "\n";

// Handling JSON errors (PHP 5.3+)
$invalidJson = "{'key': 'value'}"; // Invalid JSON (uses single quotes)
json_decode($invalidJson);
if (json_last_error() !== JSON_ERROR_NONE) {
    echo "\nJSON Decode Error: " . json_last_error_msg() . "\n";
}


// --- 10. Superglobals (Variables always available in all scopes) ---

echo "\n--- 10. Superglobals ---\n";
// Note: Accessing these directly is common, but often wrapped in functions/classes in frameworks.

echo "Some \$_SERVER variables (depend on environment):\n";
echo " SCRIPT_NAME: " . ($_SERVER['SCRIPT_NAME'] ?? 'N/A') . "\n";
echo " REQUEST_METHOD: " . ($_SERVER['REQUEST_METHOD'] ?? 'N/A') . "\n";
echo " PHP_SELF: " . ($_SERVER['PHP_SELF'] ?? 'N/A') . "\n";

echo "\n\$_GET (Data from URL query string):\n";
// Example: If URL is script.php?name=Alice&age=30
// $_GET would be ['name' => 'Alice', 'age' => 30]
print_r($_GET); // Will be empty if no query string or run via CLI

echo "\n\$_POST (Data from HTTP POST request, typically forms):\n";
print_r($_POST); // Will be empty unless form submitted via POST

// Other Superglobals (briefly mentioned):
// $_REQUEST: Contains contents of $_GET, $_POST, and $_COOKIE
// $_FILES: Contains information about uploaded files
// $_COOKIE: Contains HTTP Cookies
// $_SESSION: Contains session variables (requires session_start())
// $_ENV: Contains environment variables
// $GLOBALS: An associative array containing references to all variables currently defined in the global scope


// --- 11. Database Interaction (Basic PDO Example - requires PDO extension) ---

echo "\n--- 11. Database Interaction (PDO Example) ---\n";

// Using SQLite in-memory database for a self-contained example
$dsn = 'sqlite::memory:'; // In-memory database, exists only for the script's duration

// Check if PDO and PDO SQLite driver are available
if (!class_exists('PDO') || !in_array('sqlite', PDO::getAvailableDrivers())) {
    echo "PDO or PDO SQLite driver not available. Skipping database example.\n";
} else {
    try {
        // 1. Connect to the database
        $pdo = new PDO($dsn);
        // Set error mode to throw exceptions for better error handling
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        // Optional: Set default fetch mode
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC); // Fetch as associative arrays
        echo "PDO connection to SQLite in-memory DB successful.\n";

        // 2. Create a simple table
        $pdo->exec("CREATE TABLE IF NOT EXISTS users (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        name TEXT NOT NULL,
                        email TEXT UNIQUE
                    )");
        echo "Table 'users' created (if not exists).\n";

        // 3. Insert data using Prepared Statements (prevents SQL injection)
        $sql = "INSERT INTO users (name, email) VALUES (:name, :email)";
        $stmt = $pdo->prepare($sql);

        // Bind parameters and execute for multiple users
        $usersToInsert = [
            ['name' => 'Alice Wonder', 'email' => 'alice@example.com'],
            ['name' => 'Bob Builder', 'email' => 'bob@example.com'],
            ['name' => 'Charlie Chaplin', 'email' => 'charlie@example.com'],
        ];

        echo "Inserting users...\n";
        foreach ($usersToInsert as $user) {
            // Method 1: Bind named parameters
            $stmt->bindParam(':name', $user['name']);
            $stmt->bindParam(':email', $user['email']);
            $stmt->execute();

            // Method 2: Pass array to execute (keys must match placeholders)
            // $stmt->execute([':name' => $user['name'], ':email' => $user['email']]);
            // Or if using unnamed placeholders (?) - order matters:
            // $sql = "INSERT INTO users (name, email) VALUES (?, ?)";
            // $stmt = $pdo->prepare($sql);
            // $stmt->execute([$user['name'], $user['email']]);
        }
        echo count($usersToInsert) . " users inserted.\n";

        // 4. Select data
        echo "Fetching users:\n";
        $sqlSelect = "SELECT id, name, email FROM users WHERE id > :min_id";
        $stmtSelect = $pdo->prepare($sqlSelect);
        $minId = 1;
        $stmtSelect->bindParam(':min_id', $minId, PDO::PARAM_INT); // Specify data type
        $stmtSelect->execute();

        // Fetch results
        // $allUsers = $stmtSelect->fetchAll(); // Fetch all rows into an array
        // print_r($allUsers);

        // Or fetch one row at a time
        while ($row = $stmtSelect->fetch()) { // Uses default fetch mode (ASSOC here)
            echo " - ID: {$row['id']}, Name: {$row['name']}, Email: {$row['email']}\n";
        }

        // 5. Update data
        $sqlUpdate = "UPDATE users SET email = :new_email WHERE name = :name";
        $stmtUpdate = $pdo->prepare($sqlUpdate);
        $newName = 'Alice Wonder';
        $newEmail = 'alice.w@example.org';
        $stmtUpdate->execute([':new_email' => $newEmail, ':name' => $newName]);
        echo "Updated Alice's email. Affected rows: " . $stmtUpdate->rowCount() . "\n";

        // 6. Delete data
        $sqlDelete = "DELETE FROM users WHERE id = :id";
        $stmtDelete = $pdo->prepare($sqlDelete);
        $idToDelete = 2; // Delete Bob
        $stmtDelete->bindParam(':id', $idToDelete, PDO::PARAM_INT);
        $stmtDelete->execute();
        echo "Deleted user with ID $idToDelete. Affected rows: " . $stmtDelete->rowCount() . "\n";

        // Fetch again to see changes
        echo "Fetching users after update/delete:\n";
        $stmtAll = $pdo->query("SELECT * FROM users"); // Simple query without parameters
        while ($row = $stmtAll->fetch()) {
            echo " - ID: {$row['id']}, Name: {$row['name']}, Email: {$row['email']}\n";
        }

    } catch (PDOException $e) {
        echo "Database Error: " . $e->getMessage() . "\n";
    } finally {
        // Close connection (not strictly necessary for PDO with script end, but good practice)
        $pdo = null;
        echo "PDO connection closed.\n";
    }
}


// --- 12. Namespaces ---

echo "\n--- 12. Namespaces ---\n";

// Define code within a namespace to prevent naming collisions
namespace MyProject\Utils {

    const VERSION = '1.1';

    function logMessage(string $message): void {
        echo "[MyProject Log] " . $message . "\n";
    }

    class Helper {
        public static function generateId(): string {
            return uniqid('proj_');
        }
    }
}

// Using code from a namespace
namespace AnotherArea {

    // Import specific elements
    use MyProject\Utils\Helper;
    use MyProject\Utils\logMessage; // Importing a function
    use const MyProject\Utils\VERSION; // Importing a constant

    // Or import the entire namespace
    // use MyProject\Utils; // Then use Utils\Helper, Utils\logMessage(), Utils\VERSION

    echo "Using namespaced code:\n";
    logMessage("This is a namespaced log message."); // Using imported function
    $helper = new Helper(); // Using imported class (though method is static here)
    echo "Generated ID: " . Helper::generateId() . "\n"; // Calling static method via imported class name
    echo "Project Version: " . VERSION . "\n"; // Using imported constant

    // Using fully qualified name
    echo "Fully qualified constant: " . \MyProject\Utils\VERSION . "\n";
}


// --- End of Demonstration ---
namespace { // Return to global namespace (optional, implicit at end of file)
    echo "\n=======================================\n";
    echo " PHP Comprehensive Demonstration End \n";
    echo "=======================================\n";

    // Clean up the demo file if it exists
    if (file_exists("php_demo_file.txt")) {
        unlink("php_demo_file.txt");
        echo "\nCleaned up demo file (php_demo_file.txt).\n";
    }
}

// Closing ?> tag omitted as recommended for files containing only PHP code.
