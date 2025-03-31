/**
 * This file provides an overview of fundamental Java syntax and concepts.
 * It's not an exhaustive guide but demonstrates key aspects of the language.
 */
public class JavaLanguageOverview {

    // -------------------- Basic Structure --------------------

    /**
     * The main method is the entry point of the Java application.
     * @param args Command-line arguments passed to the program.
     */
    public static void main(String[] args) {
        System.out.println("Welcome to the Java Language Overview!");

        // -------------------- Variables and Data Types --------------------
        System.out.println("\n-- Variables and Data Types --");
        // Primitive Data Types
        byte byteVar = 10;
        short shortVar = 1000;
        int intVar = 100000;
        long longVar = 10000000000L; // 'L' suffix for long literal
        float floatVar = 3.14f;     // 'f' suffix for float literal
        double doubleVar = 3.14159;
        boolean booleanVar = true;
        char charVar = 'A';

        System.out.println("byteVar: " + byteVar);
        System.out.println("shortVar: " + shortVar);
        System.out.println("intVar: " + intVar);
        System.out.println("longVar: " + longVar);
        System.out.println("floatVar: " + floatVar);
        System.out.println("doubleVar: " + doubleVar);
        System.out.println("booleanVar: " + booleanVar);
        System.out.println("charVar: " + charVar);

        // Reference Data Types (Objects)
        String stringVar = "Hello, Java!";
        Integer integerObject = 100; // Wrapper class for primitive int

        System.out.println("stringVar: " + stringVar);
        System.out.println("integerObject: " + integerObject);

        // -------------------- Operators --------------------
        System.out.println("\n-- Operators --");
        int a = 10;
        int b = 5;

        // Arithmetic Operators
        System.out.println("a + b = " + (a + b)); // Addition
        System.out.println("a - b = " + (a - b)); // Subtraction
        System.out.println("a * b = " + (a * b)); // Multiplication
        System.out.println("a / b = " + (a / b)); // Division
        System.out.println("a % b = " + (a % b)); // Modulo (remainder)
        System.out.println("a++ = " + (a++));     // Post-increment
        System.out.println("--b = " + (--b));     // Pre-decrement

        // Comparison Operators
        System.out.println("a == b: " + (a == b));
        System.out.println("a != b: " + (a != b));
        System.out.println("a > b: " + (a > b));
        System.out.println("a < b: " + (a < b));
        System.out.println("a >= b: " + (a >= b));
        System.out.println("a <= b: " + (a <= b));

        // Logical Operators
        boolean x = true;
        boolean y = false;
        System.out.println("x && y: " + (x && y)); // Logical AND
        System.out.println("x || y: " + (x || y)); // Logical OR
        System.out.println("!x: " + (!x));       // Logical NOT

        // Assignment Operators
        int c = 5;
        c += 3; // c = c + 3
        System.out.println("c += 3: " + c);

        // -------------------- Control Flow Statements --------------------
        System.out.println("\n-- Control Flow Statements --");

        // if-else statement
        int num = 10;
        if (num > 0) {
            System.out.println(num + " is positive.");
        } else if (num < 0) {
            System.out.println(num + " is negative.");
        } else {
            System.out.println(num + " is zero.");
        }

        // switch statement
        char grade = 'B';
        switch (grade) {
            case 'A':
                System.out.println("Excellent!");
                break;
            case 'B':
                System.out.println("Good.");
                break;
            case 'C':
                System.out.println("Average.");
                break;
            default:
                System.out.println("Needs improvement.");
        }

        // -------------------- Loop Statements --------------------
        System.out.println("\n-- Loop Statements --");

        // for loop
        System.out.print("for loop (1 to 5): ");
        for (int i = 1; i <= 5; i++) {
            System.out.print(i + " ");
        }
        System.out.println();

        // while loop
        int count = 0;
        System.out.print("while loop (0 to 4): ");
        while (count < 5) {
            System.out.print(count + " ");
            count++;
        }
        System.out.println();

        // do-while loop
        int j = 0;
        System.out.print("do-while loop (0 to 4): ");
        do {
            System.out.print(j + " ");
            j++;
        } while (j < 5);
        System.out.println();

        // Enhanced for loop (for-each loop) for arrays and collections
        int[] numbers = {10, 20, 30, 40, 50};
        System.out.print("Enhanced for loop (array): ");
        for (int number : numbers) {
            System.out.print(number + " ");
        }
        System.out.println();

        // break and continue statements
        System.out.println("-- break and continue --");
        for (int i = 0; i < 10; i++) {
            if (i == 3) {
                continue; // Skip the rest of the current iteration
            }
            if (i == 7) {
                break;    // Exit the loop entirely
            }
            System.out.print(i + " "); // Output: 0 1 2 4 5 6
        }
        System.out.println();

        // -------------------- Methods (Functions) --------------------
        System.out.println("\n-- Methods --");
        int sumResult = add(15, 7);
        System.out.println("Sum of 15 and 7 is: " + sumResult);

        int factorialResult = calculateFactorial(5);
        System.out.println("Factorial of 5 is: " + factorialResult); // Demonstrates recursion

        // -------------------- Arrays --------------------
        System.out.println("\n-- Arrays --");
        int[] ages = new int [3]; // Declare an array of size 3
        ages [0] = 25;
        ages [1] = 30;
        ages [2] = 35;
        System.out.println("Age at index 1: " + ages [1]);

        String[] names = {"Alice", "Bob", "Charlie"}; // Initialize an array with values
        System.out.println("First name: " + names [0]);

        // -------------------- Object-Oriented Programming (OOP) --------------------
        System.out.println("\n-- Object-Oriented Programming --");

        // Creating an object of the Dog class
        Dog myDog = new Dog("Buddy", "Golden Retriever");
        myDog.bark(); // Calling a method of the Dog object
        System.out.println("My dog's name: " + myDog.getName());

        // Using inheritance
        Cat myCat = new Cat("Whiskers", "Siamese");
        myCat.meow(); // Cat's specific method
        myCat.makeSound(); // Inherited method (overridden in Cat)

        // Using polymorphism (method overriding)
        Animal genericAnimalDog = new Dog("GenericBuddy", "Labrador");
        Animal genericAnimalCat = new Cat("GenericWhiskers", "Persian");
        genericAnimalDog.makeSound(); // Calls Dog's makeSound()
        genericAnimalCat.makeSound(); // Calls Cat's makeSound()

        // -------------------- Exception Handling --------------------
        System.out.println("\n-- Exception Handling --");
        try {
            int result = 10 / 0; // This will cause an ArithmeticException
            System.out.println("Result: " + result); // This line will not be reached
        } catch (ArithmeticException e) {
            System.err.println("Caught an ArithmeticException: " + e.getMessage());
        } finally {
            System.out.println("Finally block executed.");
        }

        // -------------------- Classes and Objects (Further Details) --------------------
        System.out.println("\n-- Classes and Objects (Details) --");

        // Access Modifiers (public, private, protected, default) are demonstrated in the Dog and Cat classes.
        // Constructors (demonstrated in Dog and Cat classes).
        // Instance variables (name, breed in Dog and Cat).
        // Instance methods (bark, meow, makeSound).
        // Static variables and methods (not explicitly shown here for brevity, but exist).
        // 'this' keyword (implicitly used to refer to the current object).

        // -------------------- Interfaces and Abstract Classes (Illustrative) --------------------
        System.out.println("\n-- Interfaces and Abstract Classes (Illustrative) --");

        // Demonstrating an interface usage (implicitly through the SoundMaker interface)
        SoundMaker parrot = new Parrot("Polly");
        parrot.makeSound();

        // Abstract classes would be declared with the 'abstract' keyword and can have abstract methods.
        // (A full abstract class example is omitted for brevity but the concept is introduced).

        // -------------------- Generics (Basic Example) --------------------
        System.out.println("\n-- Generics (Basic Example) --");
        GenericBox<String> stringBox = new GenericBox<>("Hello Generic!");
        String content = stringBox.getContent();
        System.out.println("String Box Content: " + content);

        GenericBox<Integer> intBox = new GenericBox<>(123);
        int intContent = intBox.getContent();
        System.out.println("Integer Box Content: " + intContent);

        // -------------------- Collections (Basic Introduction - Full Library is Extensive) --------------------
        System.out.println("\n-- Collections (Basic Introduction) --");
        java.util.ArrayList<String> namesList = new java.util.ArrayList<>();
        namesList.add("David");
        namesList.add("Eve");
        System.out.println("First name in list: " + namesList.get(0));

        java.util.HashMap<String, Integer> agesMap = new java.util.HashMap<>();
        agesMap.put("Frank", 40);
        System.out.println("Age of Frank: " + agesMap.get("Frank"));
    }

    // -------------------- Methods Implementation --------------------

    /**
     * A simple method to add two integers.
     * @param num1 The first integer.
     * @param num2 The second integer.
     * @return The sum of num1 and num2.
     */
    public static int add(int num1, int num2) {
        return num1 + num2;
    }

    /**
     * A recursive method to calculate the factorial of a non-negative integer.
     * @param n The non-negative integer.
     * @return The factorial of n.
     */
    public static int calculateFactorial(int n) {
        if (n == 0) {
            return 1;
        } else {
            return n * calculateFactorial(n - 1); // Recursive call
        }
    }
}

// -------------------- Classes --------------------

/**
 * A simple class representing an Animal.
 */
class Animal {
    String name;
    String breed;

    public Animal(String name, String breed) {
        this.name = name;
        this.breed = breed;
    }

    public String getName() {
        return name;
    }

    public void makeSound() {
        System.out.println("Generic animal sound.");
    }
}

/**
 * A class representing a Dog, inheriting from Animal.
 */
class Dog extends Animal {
    public Dog(String name, String breed) {
        super(name, breed); // Call to the superclass constructor
    }

    public void bark() {
        System.out.println("Woof!");
    }

    @Override
    public void makeSound() {
        System.out.println("Dog barks: Woof woof!"); // Method overriding
    }
}

/**
 * A class representing a Cat, inheriting from Animal.
 */
class Cat extends Animal {
    public Cat(String name, String breed) {
        super(name, breed);
    }

    public void meow() {
        System.out.println("Meow!");
    }

    @Override
    public void makeSound() {
        System.out.println("Cat meows: Meow meow!"); // Method overriding
    }
}

// -------------------- Interfaces --------------------

/**
 * An example of an interface.
 */
interface SoundMaker {
    void makeSound(); // Abstract method (implicitly public)
}

/**
 * A class that implements the SoundMaker interface.
 */
class Parrot implements SoundMaker {
    String name;

    public Parrot(String name) {
        this.name = name;
    }

    @Override
    public void makeSound() {
        System.out.println(name + " says: Squawk!");
    }
}

// -------------------- Generics --------------------

/**
 * A simple generic class.
 * @param <T> The type parameter.
 */
class GenericBox<T> {
    private T content;

    public GenericBox(T content) {
        this.content = content;
    }

    public T getContent() {
        return content;
    }

    public void setContent(T content) {
        this.content = content;
    }
}
