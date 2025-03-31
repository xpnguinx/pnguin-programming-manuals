//! zig_overview.zig
//! A comprehensive (but not exhaustive) demonstration of Zig language features.
//! Compile and run with: zig run zig_overview.zig

// Import the standard library, commonly aliased to `std`.
const std = @import("std");

// Alias frequently used functions for brevity.
const print = std.debug.print;
const Allocator = std.mem.Allocator;

// NOTE: Global constant removed to troubleshoot parsing error.

// --- 1. Basic Syntax & Data Types ---

/*
   This function demonstrates basic Zig syntax including:
   - Comments (single, multi-line, doc)
   - Variable declaration (const, var)
   - Common data types (integers, floats, bools, optionals, strings, chars)
   - Optional unwrapping
   - Formatted printing
*/
fn basicSyntaxAndTypes() void {
    print("--- 1. Basic Syntax & Data Types ---\n", .{});

    // Single-line comment
    /// Documentation comment (can be used by tools)

    // `const` defines immutable variables (value must be known at compile time).
    const compile_time_int: u32 = 100;
    const inferred_float = 3.14159; // Type is inferred (f64)
    const boolean_const: bool = true;

    // `var` defines mutable variables.
    var mutable_int: i64 = -50;
    mutable_int += 10; // mutable_int is now -40

    var optional_int: ?i32 = null; // Optional type, can hold a value or null.
    optional_int = 42;

    // Strings are typically slices of constant bytes (`[]const u8`).
    const my_string: []const u8 = "This is a Zig string.";

    // Characters are unsigned 8-bit integers (`u8`).
    const my_char: u8 = 'Z';

    print("Compile-time Int: {}\n", .{compile_time_int});
    print("Inferred Float: {d:.3}\n", .{inferred_float}); // Formatted print
    print("Boolean Const: {}\n", .{boolean_const});
    print("Mutable Int: {}\n", .{mutable_int});
    if (optional_int) |value| { // Safely unwrap the optional
        print("Optional Int has value: {}\n", .{value});
    } else {
        print("Optional Int is null\n", .{});
    }
    print("String: {s}\n", .{my_string});
    print("Character: {c}\n", .{my_char});
    print("\n", .{});
}

// --- 2. Control Flow ---

// Enum used in switch example
const Status = enum { Pending, Running, Completed, Failed };

fn controlFlow() void {
    print("--- 2. Control Flow ---\n", .{});

    const value = 15;

    // If / Else If / Else
    if (value > 20) {
        print("Value is greater than 20\n", .{});
    } else if (value == 15) {
        print("Value is exactly 15\n", .{});
    } else {
        print("Value is less than 15\n", .{});
    }

    // If with variable capture (often used with optionals or error unions)
    var maybe_value: ?i32 = 10;
    if (maybe_value) |captured_value| {
        print("If captured optional value: {}\n", .{captured_value});
    } else {
        print("Optional was null\n", .{});
    }

    // Switch statement (must be exhaustive or have `else`)
    const current_status = Status.Running;
    switch (current_status) {
        .Pending => print("Status: Pending\n", .{}),
        .Running => print("Status: Running\n", .{}),
        .Completed => print("Status: Completed\n", .{}),
        .Failed => print("Status: Failed\n", .{}),
        // No `else` needed here as all enum values are covered.
    }

    // While loop
    var counter: u32 = 0;
    print("While loop: ", .{});
    while (counter < 3) {
        print("{} ", .{counter});
        counter += 1;
    }
    print("\n", .{});

    // While loop with continue condition and update expression
    counter = 0;
    print("While loop (with continue/update): ", .{});
    while (counter < 5) : (counter += 1) { // Update expression executed each iteration
        if (counter == 2) continue; // Skip iteration 2
        print("{} ", .{counter});
        if (counter == 3) break; // Exit loop early
    }
    print("\n", .{});


    // For loop (iterating over slices or arrays)
    const data = [_]i32{10, 20, 30, 40}; // Array literal (`[_]` infers size)
    print("For loop (array): ", .{});
    for (data) |item, index| { // Get item and optional index
        print("[{}]={} ", .{index, item});
    }
    print("\n", .{});

    // For loop over a slice
    const data_slice = data[1..3]; // Creates a slice {20, 30}
    print("For loop (slice): ", .{});
    for (data_slice) |item| {
        print("{} ", .{item});
    }
    print("\n", .{});

    // `inline for` for compile-time known ranges/tuples
    print("Inline For loop (compile-time range): ", .{});
    inline for (0..3) |i| { // Range must be comptime known
        print("{} ", .{i});
    }
    print("\n", .{});

    print("\n", .{});
}


// --- 3. Functions & Recursion ---

// Simple function definition
fn add(a: i32, b: i32) i32 {
    return a + b;
}

// Recursive function (factorial)
fn factorial(n: u64) u64 {
    if (n == 0) {
        return 1;
    } else {
        return n * factorial(n - 1); // Recursive call
    }
}

fn functionsAndRecursion() void {
    print("--- 3. Functions & Recursion ---\n", .{});
    const sum_result = add(10, 5);
    print("Result of add(10, 5): {}\n", .{sum_result});

    const fact_result = factorial(5);
    print("Result of factorial(5): {}\n", .{fact_result});
    print("\n", .{});
}

// --- 4. Error Handling ---

// Define a custom error set.
const MyError = error{
    InvalidInput,
    OutOfMemory,
    FileNotFound,
};

// A function that can return an i32 or a MyError.
// The `!` indicates an error union type. `MyError!i32`
fn canFail(input: i32) MyError!i32 {
    if (input < 0) {
        return MyError.InvalidInput; // Return an error
    }
    if (input > 1000) {
        // Pretend we ran out of memory for large inputs
        return MyError.OutOfMemory;
    }
    return input * 2; // Return success value
}

// Function using `try` to propagate errors. It returns `anyerror!void`.
// `anyerror` can hold any error defined in the program.
fn processValue(value: i32) !void { // `!void` implies `anyerror!void`
    const result = try canFail(value); // If canFail returns error, processValue returns it.
    print("Processed value {} -> {}\n", .{value, result});

    // If we only wanted to propagate *our* errors, we could specify:
    // const result2 = try canFail(value); // Type: MyError!i32
}

fn errorHandling() void {
    print("--- 4. Error Handling ---\n", .{});

    // Using `try` within a block that can catch errors
    const result1 = canFail(50);
    if (result1) |value| {
        print("Success (direct call): {}\n", .{value});
    } else |err| {
        print("Error (direct call): {}\n", .{err}); // Prints '.InvalidInput' or '.OutOfMemory'
    }

    // Using `catch` to handle errors immediately and provide a default.
    const result2 = canFail(-10) catch |err| {
        print("Caught error with catch: {}\n", .{err});
        return -1; // Default value on error
    };
    print("Result after catch (error case): {}\n", .{result2});

    const result3 = canFail(20) catch |err| {
        print("Caught error with catch (success case, won't print): {}\n", .{err});
        return -1;
    };
    print("Result after catch (success case): {}\n", .{result3});

    // Using `try` and letting the calling function handle the error
    // Note: `main` needs `!void` return type if we `try` here directly.
    // We'll call `processValue` which uses `try`.
    processValue(100) catch |err| {
        print("Caught error from processValue(100): {}\n", .{err}); // Should not happen
    };
    processValue(-5) catch |err| {
        print("Caught error from processValue(-5): {}\n", .{err}); // Prints '.InvalidInput'
    };
    processValue(2000) catch |err| {
        print("Caught error from processValue(2000): {}\n", .{err}); // Prints '.OutOfMemory'
    };

    print("\n", .{});
}

// --- 5. Defer & Errdefer ---

// Needs an allocator passed in, demonstrates resource cleanup.
fn deferAndErrdefer(allocator: Allocator) !void {
    print("--- 5. Defer & Errdefer ---\n", .{});

    print("Allocating resource...\n", .{});
    var data = try allocator.alloc(u8, 10); // Allocate 10 bytes

    // `defer` schedules code to run when the current block scope exits.
    // Runs whether the block exits normally or via error.
    // Useful for releasing resources. Runs in LIFO order if multiple defers.
    defer {
        print("Defer: Freeing allocated data.\n", .{});
        allocator.free(data);
    }

    var file_handle: ?*OpaqueFile = null; // Simulate a file handle (opaque type)
    const OpaqueFile = opaque {}; // Dummy opaque type

    // `errdefer` schedules code to run ONLY IF the scope exits due to an error
    // occurring *after* the errdefer statement.
    errdefer {
        print("Errdefer: Closing file handle due to error.\n", .{});
        // In real code: closeFile(file_handle.?);
        _ = file_handle; // Use the variable
    }

    print("Simulating opening file...\n", .{});
    var dummy_file: OpaqueFile = .{};
    file_handle = &dummy_file; // Pretend we got a handle

    print("Performing operations...\n", .{});
    data[0] = 'A';
    print("Data[0] set to: {c}\n", .{data[0]});

    // Uncomment the next line to trigger an error and see errdefer run.
    // _ = try canFail(-1); // This error would trigger the errdefer above.

    // If no error occurred after errdefer, it doesn't run.
    // The regular `defer` for freeing `data` WILL run regardless.

    print("Exiting scope normally (or after error handled)...\n", .{});
    print("\n", .{});
}


// --- 6. Structs (OOP-like Features) ---

const Vector2D = struct {
    // Fields
    x: f32,
    y: f32,

    // Constant associated with the struct
    const ZERO = Vector2D{ .x = 0.0, .y = 0.0 };

    // Associated function (like a static method). Doesn't take `this`.
    pub fn create(x: f32, y: f32) Vector2D {
        return Vector2D{ .x = x, .y = y };
    }

    // Method taking `this` by value (instance is copied).
    pub fn magnitude(this: Vector2D) f32 {
        const x2 = this.x * this.x;
        const y2 = this.y * this.y;
        return @sqrt(x2 + y2); // @sqrt is a builtin function
    }

    // Method taking `this` by pointer (modifies the instance).
    pub fn scale(this: *Vector2D, factor: f32) void {
        this.x *= factor;
        this.y *= factor;
    }

    // Implementing the `format` function allows `print` to format this struct.
    pub fn format(
        this: Vector2D,
        comptime fmt_str: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        // Ignore fmt_str and options for simplicity
        _ = fmt_str;
        _ = options;
        try writer.print("Vector2D(x={d:.2}, y={d:.2})", .{ this.x, this.y });
    }
};

fn structsDemo() void {
    print("--- 6. Structs ---\n", .{});

    var vec1 = Vector2D.create(3.0, 4.0);
    const vec2 = Vector2D{ .x = 1.0, .y = -1.0 }; // Struct literal

    print("Vector 1: {}\n", .{vec1}); // Uses the format method
    print("Vector 2: {}\n", .{vec2});
    print("Zero Vector: {}\n", .{Vector2D.ZERO});

    const mag = vec1.magnitude();
    print("Magnitude of vec1: {d:.2}\n", .{mag});

    vec1.scale(2.0); // Modify vec1 using the pointer method
    print("Vector 1 scaled by 2.0: {}\n", .{vec1});

    print("\n", .{});
}

// --- 7. Unions ---

// Tagged union: holds one of several types, knows which one it holds.
const DataPacket = union(enum) {
    Integer: i64,
    Floating: f64,
    Message: []const u8, // Slice for string data

    // Methods can be defined on unions too
    fn printInfo(this: DataPacket) void {
        switch (this) {
            .Integer => |val| print("Packet contains Integer: {}\n", .{val}),
            .Floating => |val| print("Packet contains Float: {d:.4}\n", .{val}),
            .Message => |val| print("Packet contains Message: \"{s}\"\n", .{val}),
        }
    }
};

fn unionsDemo() void {
    print("--- 7. Unions ---\n", .{});

    var packet1: DataPacket = .{ .Integer = 12345 };
    var packet2: DataPacket = .{ .Message = "Packet Data" };
    var packet3: DataPacket = .{ .Floating = 9.87654 };

    packet1.printInfo();
    packet2.printInfo();
    packet3.printInfo();

    // Accessing the wrong field is a compile-time error if known,
    // or a runtime safety crash if not known at compile time.
    // print("{s}\n", .{packet1.Message}); // COMPILE ERROR!

    print("\n", .{});
}


// --- 8. Comptime ---

// Function executed entirely at compile time
fn comptimeFactorial(comptime n: u32) u32 {
    if (n == 0) return 1;
    return n * comptimeFactorial(n - 1);
}

// Using comptime to generate types or data structures
fn createPointType(comptime Dim: u32, comptime T: type) type {
    return struct {
        coords: [Dim]T,

        // Add a method to the generated type
        fn printCoords(this: @This()) void {
            print("Point{d}D(", .{Dim});
            inline for (this.coords) |c, i| {
                if (i > 0) print(", ", .{});
                // Use generic format specifier {any} which works for many types
                print("{any}", .{c});
            }
            print(")\n", .{});
        }
    };
}

fn comptimeDemo() void {
    print("--- 8. Comptime ---\n", .{});

    // Value computed at compile time, becomes a constant in the binary.
    const fact5_comptime = comptimeFactorial(5);
    print("Factorial(5) computed at comptime: {}\n", .{fact5_comptime});

    // Generate specific struct types at compile time
    const Point2D_f32 = createPointType(2, f32);
    const Point3D_i16 = createPointType(3, i16);

    // Use the generated types
    var p1 = Point2D_f32{ .coords = .{ 1.5, -2.5 } };
    var p2 = Point3D_i16{ .coords = .{ 10, -20, 30 } };

    print("Type name of p1: {s}\n", .{@typeName(@TypeOf(p1))}); // Reflection with @typeName
    p1.printCoords(); // Call method on generated type

    print("Type name of p2: {s}\n", .{@typeName(@TypeOf(p2))});
    p2.printCoords();

    // Comptime conditional compilation
    const enable_debug_feature = true; // Change to false and recompile
    comptime {
        if (enable_debug_feature) {
            print("Debug feature is COMPILED IN.\n", .{});
        } else {
            // This code block is completely removed if enable_debug_feature is false
             print("Debug feature is NOT compiled in.\n", .{});
        }
    }

    print("\n", .{});
}

// --- 9. Arrays, Slices, Pointers ---

fn arraysSlicesPointersDemo() void {
    print("--- 9. Arrays, Slices, Pointers ---\n", .{});

    // Array: Fixed size known at compile time, stores values directly.
    var my_array: [4]u8 = [_]u8{ 10, 20, 30, 40 }; // Size 4
    print("Array (value): {any}\n", .{my_array});

    // Slice: Pointer + Length. References a part of an array (or other memory).
    var my_slice: []u8 = my_array[1..3]; // Slice elements at index 1 and 2 -> {20, 30}
    print("Slice (len={}): {any}\n", .{ my_slice.len, my_slice });

    // Modifying the slice modifies the underlying array.
    my_slice[0] = 25;
    print("Slice after modification: {any}\n", .{my_slice});
    print("Array after slice modification: {any}\n", .{my_array}); // my_array is now {10, 25, 30, 40}

    // Pointer: Stores a memory address.
    var value: i32 = 100;
    var ptr: *i32 = &value; // `&` gets the address. `*i32` is a pointer to i32.

    print("Value: {}, Address: {*}\n", .{ value, ptr }); // Print pointer address with {*}
    print("Value via pointer dereference (ptr.*): {}\n", .{ptr.*});

    // Modify the original value through the pointer.
    ptr.* = 200;
    print("Value after modification via pointer: {}\n", .{value});

    // Slices are essentially pointers with length.
    print("Slice pointer address: {*}\n", .{my_slice.ptr});

    print("\n", .{});
}

// --- 10. Anonymous Struct Literals (Tuples) ---

fn anonymousLiteralsDemo() void {
    print("--- 10. Anonymous Struct Literals (Tuples) ---\n", .{});

    // Anonymous struct literal: useful for one-off data grouping.
    const data = .{
        .name = "Widget",
        .id = 123,
        .enabled = true,
    };
    print("Anonymous Struct: name={s}, id={}, enabled={}\n", .{ data.name, data.id, data.enabled });

    // Tuple literal: Anonymous struct with fields named "0", "1", "2", ...
    const my_tuple = .{ "Zig", 2024, false }; // Types: []const u8, comptime_int, bool
    print("Tuple: [0]={s}, [1]={}, [2]={}\n", .{ my_tuple[0], my_tuple[1], my_tuple[2] });
    // Can also access fields like: my_tuple.@"0", my_tuple.@"1"
    print("Tuple element 0 via .@\"0\": {s}\n", .{my_tuple.@"0"});

    print("\n", .{});
}


// --- Entry Point ---

// The main function is the program's entry point.
// It returns `!void` because some functions we call (like memory allocation) can fail.
pub fn main() !void {
    // NOTE: Print statement using GLOBAL_MESSAGE removed.
    print("Starting Zig Overview...\n\n", .{}); // Added a placeholder message

    basicSyntaxAndTypes();
    controlFlow();
    functionsAndRecursion();
    errorHandling();

    // Memory management demos require an allocator.
    // GeneralPurposeAllocator is a good default for many applications.
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // Ensure the allocator's resources are cleaned up when main exits.
    // The `._ =` ignores potential deinitialization errors for this demo.
    defer _ = gpa.deinit();
    const allocator = gpa.allocator(); // Get the allocator interface

    // Call functions requiring the allocator. Use `try` as they can fail.
    try deferAndErrdefer(allocator);

    structsDemo();
    unionsDemo();
    comptimeDemo();
    arraysSlicesPointersDemo();
    anonymousLiteralsDemo();

    print("--- Zig Overview Complete ---\n", .{});
}