(* ocaml_tour.ml - A Tour of the OCaml Language *)

(* This file demonstrates various features of the OCaml language.
   You can compile it using: ocamlc ocaml_tour.ml -o ocaml_tour
   Or run it interpreted: ocaml ocaml_tour.ml
   Or load it into the interactive toplevel (REPL): ocaml
   # #use "ocaml_tour.ml";;
   It's highly recommended to use the 'dune' build system for real projects.
*)

(* 1. Basic Syntax, Let Bindings, Types, Comments *)
(* Single-line comments start with (* and end with *) *)
(* Multi-line comments
   are also enclosed
   like this. *)

(* 'let' binds a name to a value. Type inference usually works. *)
let an_integer = 42
let a_float = 3.14
let a_boolean = true
let a_string = "Hello, OCaml!"
let a_char = 'a'

(* You can add explicit type annotations *)
let another_integer : int = 100
let another_string : string = "Type annotation"

(* The 'unit' type has only one value: () - often used for side effects *)
let nothing : unit = ()

(* Printf module is commonly used for formatted printing *)
let () = Printf.printf "--- 1. Basics ---\n"
let () = Printf.printf "An integer: %d, A float: %f, A boolean: %b\n" an_integer a_float a_boolean
let () = Printf.printf "A string: %s, A char: %c\n" a_string a_char

(* 2. Primitive Data Types - Already shown above (int, float, bool, string, char, unit) *)

(* 3. Operators *)
let () = Printf.printf "\n--- 3. Operators ---\n"
(* Integer arithmetic *)
let sum = 10 + 5
let diff = 10 - 5
let prod = 10 * 5
let quot = 10 / 5 (* Integer division *)
let modu = 10 mod 3

(* Float arithmetic - Note the '.' after operators *)
let f_sum = 10.0 +. 5.0
let f_diff = 10.0 -. 5.0
let f_prod = 10.0 *. 5.0
let f_quot = 10.0 /. 5.0
(* No specific float modulo operator, use Float.rem *)

(* String concatenation *)
let combined_string = "Hello" ^ " " ^ "World!"

(* Boolean logic *)
let logic_and = true && false
let logic_or = true || false
let logic_not = not true

(* Comparison (polymorphic: work on most types) *)
let equal = (5 = 5)
let not_equal = (5 <> 6)
let greater_than = (5 > 3)
let less_equal = (5 <= 5)

let () = Printf.printf "Sum: %d, F_Sum: %f, Combined: %s, Logic AND: %b, Equal: %b\n"
  sum f_sum combined_string logic_and equal

(* 4. Tuples, Records, Lists, Arrays *)
let () = Printf.printf "\n--- 4. Compound Data Types ---\n"

(* Tuples: Fixed-size, heterogeneous collection *)
let a_pair = (10, "ten")
let a_triple = (true, 'b', 3.0)

(* Accessing tuple elements (no direct access by index, use pattern matching) *)
let (fst_val, snd_val) = a_pair
let () = Printf.printf "Tuple: (%d, %s)\n" fst_val snd_val

(* Records: Like tuples, but fields have names *)
type person = { name : string; age : int; mutable location : string } (* 'mutable' allows field update *)
let alice = { name = "Alice"; age = 30; location = "Wonderland" }

(* Accessing record fields *)
let () = Printf.printf "Record: Name=%s, Age=%d, Location=%s\n" alice.name alice.age alice.location

(* Updating mutable record fields *)
let () = alice.location <- "Oxford"
let () = Printf.printf "Record Updated: Location=%s\n" alice.location

(* Lists: Ordered, homogeneous, immutable, linked-list based *)
let empty_list = []
let int_list = [1; 2; 3; 4; 5]
let string_list = ["a"; "b"; "c"]

(* Cons operator '::' adds element to the front *)
let longer_list = 0 :: int_list (* [0; 1; 2; 3; 4; 5] *)

(* List concatenation with '@' (can be slow for long lists) *)
let combined_list = int_list @ [6; 7]

(* Common List operations (usually from the List module) *)
let list_length = List.length int_list
let list_head = List.hd int_list (* Raises exception if list is empty *)
let list_tail = List.tl int_list (* Raises exception if list is empty *)
let third_element = List.nth int_list 2 (* Raises exception if index out of bounds *)
let doubled_list = List.map (fun x -> x * 2) int_list

let () = Printf.printf "List: Head=%d, Length=%d\n" list_head list_length
let () = Printf.printf "Doubled list: [%s]\n" (String.concat "; " (List.map string_of_int doubled_list))

(* Arrays: Fixed-size, mutable, homogeneous *)
let int_array = [|10; 20; 30|]
let string_array = Array.make 5 "init" (* Creates an array of size 5 with "init" *)

(* Accessing and modifying array elements (0-based index) *)
let first_element = int_array.(0)
let () = int_array.(1) <- 25 (* Modify element at index 1 *)

let () = Printf.printf "Array: First=%d, Modified element at index 1: %d\n" first_element int_array.(1)
let array_length = Array.length int_array
let () = Printf.printf "Array length: %d\n" array_length

(* 5. Options and Variants (Algebraic Data Types) *)
let () = Printf.printf "\n--- 5. Options and Variants ---\n"

(* Option type: Represents the presence or absence of a value *)
type 'a option = None | Some of 'a (* Defined in standard library *)

let maybe_value : int option = Some 10
let no_value : string option = None

(* Handle options using pattern matching *)
let print_option opt =
  match opt with
  | Some v -> Printf.printf "Got value: %d\n" v
  | None -> Printf.printf "Got nothing (None)\n"

let () = print_option maybe_value
let () = print_option (None : int option) (* Need type hint if None is alone *)

(* Variants (Sum Types): Define a type that can be one of several possibilities *)
type shape =
  | Circle of float (* radius *)
  | Rectangle of float * float (* width * height *)
  | Point

let circle = Circle 5.0
let rect = Rectangle (3.0, 4.0)
let p = Point

(* Use pattern matching to work with variants *)
let calculate_area s =
  match s with
  | Circle r -> Float.pi *. r *. r
  | Rectangle (w, h) -> w *. h
  | Point -> 0.0

let () = Printf.printf "Area of circle: %f\n" (calculate_area circle)
let () = Printf.printf "Area of rectangle: %f\n" (calculate_area rect)
let () = Printf.printf "Area of point: %f\n" (calculate_area p)

(* 6. Control Flow (if/else, match) *)
let () = Printf.printf "\n--- 6. Control Flow ---\n"

(* if/then/else expression (must return the same type in both branches) *)
let check_number n =
  if n > 0 then
    "Positive"
  else if n < 0 then
    "Negative"
  else
    "Zero"

let () = Printf.printf "Number 5 is %s\n" (check_number 5)
let () = Printf.printf "Number -3 is %s\n" (check_number (-3))

(* 'match' expression: Powerful pattern matching *)
let describe_list lst =
  match lst with
  | [] -> "The list is empty."
  | [x] -> Printf.sprintf "The list has one element: %d" x
  | x :: y :: [] -> Printf.sprintf "The list has two elements: %d and %d" x y
  | h :: t -> Printf.sprintf "The list starts with %d and has %d more elements." h (List.length t)

let () = Printf.printf "%s\n" (describe_list [])
let () = Printf.printf "%s\n" (describe_list [42])
let () = Printf.printf "%s\n" (describe_list [10; 20])
let () = Printf.printf "%s\n" (describe_list [1; 2; 3; 4])

(* Match with guards *)
let describe_number n =
  match n with
  | x when x > 0 -> "Positive"
  | x when x < 0 -> "Negative"
  | 0 -> "Zero"
  | _ -> "Should not happen for int" (* Wildcard _ matches anything *)

(* 7. Loops (for, while) - More imperative style *)
let () = Printf.printf "\n--- 7. Loops ---\n"

(* 'for' loop: Iterates over a range *)
let () = Printf.printf "For loop 0 to 3: "
let () = for i = 0 to 3 do
  Printf.printf "%d " i
done
let () = Printf.printf "\n"

(* 'while' loop: Executes while a condition is true *)
(* Requires a mutable reference typically *)
let counter = ref 0
let () = Printf.printf "While loop (counter < 3): "
let () = while !counter < 3 do
  Printf.printf "%d " !counter;
  counter := !counter + 1 (* Increment the reference *)
done
let () = Printf.printf "\n"

(* Note: Functional iteration using List.iter, List.map etc. is often preferred *)
let () = Printf.printf "Functional iteration (List.iter): "
let () = List.iter (fun x -> Printf.printf "%d " x) [5; 6; 7]
let () = Printf.printf "\n"

(* 8. Functions *)
let () = Printf.printf "\n--- 8. Functions ---\n"

(* Simple function definition *)
let add x y = x + y
let () = Printf.printf "add 3 4 = %d\n" (add 3 4)

(* Recursive function: requires 'let rec' *)
let rec factorial n =
  if n <= 1 then 1 else n * factorial (n - 1)
let () = Printf.printf "factorial 5 = %d\n" (factorial 5)

(* Tail-recursive function (optimized, avoids stack overflow for deep recursion) *)
let rec factorial_tailrec n acc =
  if n <= 1 then acc else factorial_tailrec (n - 1) (n * acc)
(* User-facing function often hides the accumulator *)
let factorial' n = factorial_tailrec n 1
let () = Printf.printf "factorial' 5 = %d\n" (factorial' 5)

(* Higher-order functions: Take functions as arguments or return functions *)
let apply_twice f x = f (f x)
let square x = x * x
let () = Printf.printf "apply_twice square 3 = %d\n" (apply_twice square 3)

(* Anonymous functions (lambdas) *)
let double_list' = List.map (fun x -> x * 2) [1; 2; 3]
let () = Printf.printf "Anonymous function with List.map: [%s]\n" (String.concat "; " (List.map string_of_int double_list'))

(* Labeled arguments (~label) *)
let divide ~numerator ~denominator =
  if denominator = 0.0 then None else Some (numerator /. denominator)

let result = divide ~numerator:10.0 ~denominator:2.0
let () = match result with Some v -> Printf.printf "10.0 / 2.0 = %f\n" v | None -> ()
(* Order doesn't matter with labeled arguments *)
let result' = divide ~denominator:5.0 ~numerator:20.0
let () = match result' with Some v -> Printf.printf "20.0 / 5.0 = %f\n" v | None -> ()

(* Optional arguments (?label) - They are passed as 'option' types *)
let greet ?(title="Mx.") name =
  Printf.printf "Hello, %s %s!\n" title name

let () = greet "Alice" (* Uses default title *)
let () = greet ~title:"Dr." "Bob" (* Provides title *)

(* Optional arguments can have default values *)
let configure ?(port=8080) ?(host="localhost") () =
  Printf.printf "Configuring server on %s:%d\n" host port

let () = configure () (* Uses both defaults *)
let () = configure ~port:9000 () (* Overrides port *)
let () = configure ~host:"example.com" ~port:80 () (* Overrides both *)


(* 9. Mutability *)
let () = Printf.printf "\n--- 9. Mutability ---\n"

(* References: The primary way to have mutable variables *)
let mutable_counter = ref 0
let () = Printf.printf "Initial counter value: %d\n" !mutable_counter (* '!' dereferences *)
let () = mutable_counter := !mutable_counter + 1 (* ':=' assigns *)
let () = Printf.printf "Incremented counter value: %d\n" !mutable_counter

(* Mutable record fields were shown in section 4 *)
let () = Printf.printf "Alice's location (mutable field) is now: %s\n" alice.location

(* Arrays are mutable (shown in section 4) *)
let () = int_array.(0) <- 100
let () = Printf.printf "Array element 0 changed to: %d\n" int_array.(0)

(* Note: Immutability is generally preferred in OCaml, use mutability judiciously. *)


(* 10. Exceptions *)
let () = Printf.printf "\n--- 10. Exceptions ---\n"

(* Defining custom exceptions *)
exception DivisionByZero
exception NegativeInput of int

(* Function that might raise an exception *)
let safe_sqrt x =
  if x < 0.0 then raise (NegativeInput (int_of_float x))
  else sqrt x

let divide_exn x y =
  if y = 0 then raise DivisionByZero else x / y

(* Handling exceptions with try...with *)
let attempt_division x y =
  try
    let result = divide_exn x y in
    Printf.printf "%d / %d = %d\n" x y result
  with
  | DivisionByZero -> Printf.printf "Error: Cannot divide %d by zero!\n" x
  | exn -> Printf.printf "An unexpected error occurred: %s\n" (Printexc.to_string exn)

let () = attempt_division 10 2
let () = attempt_division 10 0

let attempt_sqrt x =
  try
    let result = safe_sqrt x in
    Printf.printf "sqrt(%f) = %f\n" x result
  with
  | NegativeInput n -> Printf.printf "Error: Cannot take sqrt of negative number %d\n" n

let () = attempt_sqrt 16.0
let () = attempt_sqrt (-4.0)


(* 11. Modules and Signatures *)
let () = Printf.printf "\n--- 11. Modules and Signatures ---\n"

(* Define a module *)
module MyMath = struct
  let pi = 3.14159
  let add x y = x + y (* Shadowing the global 'add' inside the module *)
  let square x = x * x
end

(* Access elements using dot notation *)
let () = Printf.printf "MyMath.pi = %f\n" MyMath.pi
let () = Printf.printf "MyMath.add 5 5 = %d\n" (MyMath.add 5 5)

(* Define a module signature (interface) *)
module type MATH_SIG = sig
  val pi : float
  val add : int -> int -> int (* Specifies the type of 'add' *)
  (* 'square' is not listed, so it will be hidden if we apply this signature *)
end

(* Apply the signature to the module *)
module LimitedMath : MATH_SIG = MyMath

(* Now 'square' is not accessible via LimitedMath *)
let () = Printf.printf "LimitedMath.pi = %f\n" LimitedMath.pi
(* This would cause a compile error: Unbound value LimitedMath.square *)
(* let s = LimitedMath.square 3 *)

(* Opening a module brings its contents into the current scope *)
(* Use 'open' sparingly to avoid namespace pollution *)
let calculate_circle_area r =
  let open MyMath in (* Open locally *)
  pi *. (float_of_int (square r)) (* Uses MyMath.pi and MyMath.square *)

(* Or open globally (less recommended) *)
(* open MyMath *)
(* let area = pi *. (float_of_int (square 10)) *)

let () = Printf.printf "Area using opened module: %f\n" (calculate_circle_area 10)

(* Functors: Modules parameterized by other modules (more advanced) *)
module MakeLogger (Prefix : sig val prefix : string end) = struct
  let log message = Printf.printf "[%s] %s\n" Prefix.prefix message
end

module AppLogger = MakeLogger (struct let prefix = "APP" end)
module DbLogger = MakeLogger (struct let prefix = "DB" end)

let () = AppLogger.log "Application started."
let () = DbLogger.log "Query executed."


(* 12. Object-Oriented Features *)
(* OCaml's OO system is powerful but often less used than its functional/module features *)
let () = Printf.printf "\n--- 12. Object-Oriented Features ---\n"

(* Define a class *)
class counter_class initial_value =
  object (self) (* 'self' is conventional name for the object itself *)
    val mutable count = initial_value (* Instance variable (private by default) *)

    method get_count = count (* Public method to access count *)

    method increment = count <- count + 1

    method reset = count <- initial_value

    method print = Printf.printf "Counter value: %d\n" count
end

(* Create objects (instances) *)
let c1 = new counter_class 0
let c2 = new counter_class 10

let () = c1#increment (* Call method using '#' *)
let () = c1#increment
let () = c1#print
let () = Printf.printf "c1 count via get_count: %d\n" c1#get_count

let () = c2#print
let () = c2#reset
let () = c2#print

(* Inheritance *)
class verbose_counter_class initial =
  object
    inherit counter_class initial as super (* Inherit from counter_class *)

    method! increment = (* Override method using 'method!' *)
      Printf.printf "Incrementing... ";
      super#increment; (* Call superclass method *)
      Printf.printf "New value: %d\n" count (* Can access inherited mutable state *)

end

let vc = new verbose_counter_class 5
let () = vc#increment
let () = vc#print


(* 13. Basic Input/Output *)
let () = Printf.printf "\n--- 13. Basic I/O ---\n"

(* Printing (already used extensively with Printf) *)
let () = print_string "This prints a string."
let () = print_newline () (* Equivalent to print_string "\n" *)
let () = print_endline "This prints a string followed by a newline."
let () = print_int 42
let () = print_newline ()
let () = print_float 3.14
let () = print_newline ()

(* Reading input (simple example) *)
(* Uncomment the following lines to test reading *)
(*
let () = print_string "Enter your name: "
let name = read_line () (* Reads a line from standard input *)
let () = Printf.printf "Hello, %s!\n" name

let () = print_string "Enter a number: "
let num_str = read_line ()
let num = try int_of_string num_str with Failure _ -> 0
let () = Printf.printf "You entered (integer): %d\n" num
*)


(* --- End of Tour --- *)
let () = Printf.printf "\n--- End of OCaml Tour ---\n"
