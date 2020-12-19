open OUnit2
open Scenario
open Storage
open Student
open Friend
open Hangman
open Wordsearch


(**---------------------------------TEST PLAN------------------------------

   Argument for testing approach:

    For the majority of our project, we used interactive play testing. From the
   very beginning of this assignment, we used test-driven development with a 
   product that had some start-to-end functionality. When we added on a
   new feature, we integrated the feature into the rest of the system and then
   tested the whole system, isolating the new functionality. Each piece is part
   of a "bigger puzzle", and so we could always see the most recent version of
   the combined product, and thus always had something that we could show to 
   the client at a moment's notice. This approach was especially useful when
   designing a game, because it allowed us not only to build functionality, but
   also focus on aspects of design and ways to make it more fun along the way. 
   For the play testing, we primarily used the terminal, and then after MS2, we
   transitioned to a GUI using OCaml graphics. 

     For the test suites that we did include, we tested some smaller parts, such 
    as text based functions, helper functions in the minigames, or transitions
    (such as from one scenario to another). Since the majority of functions were
    printed directly into the terminal (or later the GUI), and were based on
   -user input, it made more sense to test them by integrating them into
     the program and then interactively play-testing them


   Modules tested by OUnit:

   We tested the following modules using OUnit:
   - Student
   - Scenario
   - Friend
   - Hangman 
   - Wordsearch
   - Scrambler

    We tested the modules that had to do with the main RPG functionality (such
   as transitioning from one scenario to another or updating a student) with 
   glass box testing, becasue this allowed us to use more specific corner cases.
   For such an important aspect of our project, this is incredibly important 
   because we do not know what the user might try to do! These modules included
   Student, Scenario, and Friend.

    The rest of the modules that we tested corresponded with various minigames,
   such as Hangman, Wordsearch and Scrambler. We tested various helper functions
   using black-box testing, and then tested the combined functionality (the 
   whole minigame all put together) using play testing. We tested these 
   minigames both in isolation, and then integrated with the rest of the game.

    Overall, the majority of the functionality was interactively tested. 
   Additionally, parts that were not specifically tested in the OUnit test suite 
   were either used directly or indirectly in the interactive testing.
*)

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt]
    to pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "[" ^ pp_elts lst ^ "]"

(** [cmp_set_like_lists lst1 lst2] compares two lists to see whether
    they are equivalent set-like lists.  That means checking two things.
    First, they must both be {i set-like}, meaning that they do not
    contain any duplicates.  Second, they must contain the same elements,
    though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  &&
  List.length lst2 = List.length uniq2
  &&
  uniq1 = uniq2

let friend_a = Friend.make_friend "kevin" 5 
let friend_a_updated = Friend.make_friend "kevin" 9 
let friend_a_updated_worth = Friend.make_friend "kevin" 5 
let friend_a_both = Friend.make_friend "kevin" 9 
let friend_b = Friend.make_friend "joe" 5 

let student_a = Student.make_student "student" 18 0.0 0.0 0.0 0.0 0.0 [] []
let student_b = Student.make_student "student" 18 4.0 0.0 0.0 0.0 0.0 [] [""]
let student_c = Student.make_student "student" 18 4.0 0.0 0.0 0.0 0.0 
    [friend_a] ["";""]
let student_d = Student.make_student "student" 18 10.0 3.0 8.0 40.0 10.5 
    [friend_a] ["";""; ""]
let student_give_money = 
  Student.make_student "student" 18 0.0 0.0 0.0 0.0 3.0 [] []
let student_age = Student.make_student "student" 19 0.0 0.0 0.0 0.0 0.0 [] []
let student_friends = 
  Student.make_student "student" 18 0.0 0.0 0.0 0.0 0.0 [friend_a; friend_b] []
let student_a_check_decisions = 
  Student.make_student "student" 18 0.0 0.0 0.0 0.0 0.0 [] ["Double"]


let return_consequences_test name decision choices player expected_output  =
  name >:: fun ctxt -> assert_equal (cmp_set_like_lists (expected_output) 
                                       (Scenario.return_consequences decision 
                                          choices player)) true

let return_consequences_error_test name decision choices player expected_output  
  =
  name >:: fun ctxt -> assert_raises expected_output (fun () -> 
      (Scenario.return_consequences decision choices player))

let return_scenario_name_test name scenario expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Scenario.return_scenario_name scenario)

let return_choices_test name scenario expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Scenario.return_choices scenario)

let update_friend_test name friend closeness expected_output =
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Friend.update_friend friend closeness )

let give_money_test name student expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Student.give_money student)

let update_age_test name student expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Student.update_age student)

let update_friend_list_only_test name student friends_list expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Student.update_friend_list_only student friends_list)

let update_student_test name student morality gpa social_life health brbs 
    friends dec expected_output =
  name >:: (fun _ -> assert_equal expected_output 
               (Student.update_student student morality gpa social_life health 
                  brbs friends dec))

let scramble_engine_test name word input expected_output = 
  name >:: (fun _ -> assert_equal expected_output 
               (Scrambler.scramble_engine word input))

let check_decisions_test name decision student expected_output = 
  name >:: (fun _ -> assert_equal expected_output 
               (Student.check_decisions decision student))

let check_prereq_test name scenario expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Scenario.check_prereq scenario)

let go_through_unlocks_test name unlock_list choice expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Scenario.go_through_unlocks unlock_list choice)

let go_through_unlocks_error_test name unlock_list choice expected_output = 
  name >:: fun ctxt -> assert_raises expected_output 
      (fun () -> (Scenario.go_through_unlocks unlock_list choice)) 

let main_friend_function_test name decision expected_output = 
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Scenario.main_friend_function decision)

let make_list_of_strings_test name phrase expected_output =
  name >:: fun _ -> assert_equal ~cmp:cmp_set_like_lists (expected_output) 
      ~printer:(pp_list pp_string)
      (Hangman.make_list_of_strings phrase)

let replace_in_lst_test name lst n value expected_output=
  name >:: fun _ -> assert_equal
      (* ~cmp:cmp_set_like_lists  *)
      (expected_output) 
      (* ~printer:(pp_list pp_string) *)
      (Wordsearch.replace_in_lst lst n value)
let replace_h_test name init_lst word_lst starting_pos length expected_output=
  name >:: fun _ -> assert_equal
      (* ~cmp:cmp_set_like_lists  *)
      (expected_output) 
      (* ~printer:(pp_list pp_string) *)
      (Wordsearch.replace_h init_lst word_lst starting_pos length)

let rev_nested_lst_test name lst expected_value =
  name >:: fun _ -> assert_equal expected_value (Wordsearch.rev_nested_lst lst)



let roommate_and_brad = 
  Scenario.make_scenario "Roommate and Brad" 
    "Your roommate's friend comes with you, but unfortunately needs a little \
          ~help going home..." 
    ["Help them home"; "Leave without them"] 

let love = Scenario.make_scenario "love"
    "Oop, things seem to be getting serious <3. Would you like to make things\
   ~official with them ?"
    ["I'm falling for them"; "I have commitment issues"]

let startup =  Scenario.make_scenario "startup" 
    "~Your friend Maximillian the III is making a startup as a side hustle. \
    ~Do you wanna be a part of it? It might take some time out of your semester\
    ~but it'll definitely look good on your resume."
    ["Startup"; "Meh. I would only work for Google"]

let grad_school =  Scenario.make_scenario "grad school" 
    "~Grad school applications are starting to be due. Would you like to apply \
    ~to a grad school?"
    ["Grad school"; "Industry"]

let wines = Scenario.make_scenario "wines" 
    "~It is your very last semester at Cornell!! This means that this is your \
    ~last chance to take any course before you leave. Everyone talks about \
    ~taking the wine course at Cornell. Shall we raise a glass?" 
    ["White wine please"; "I don't drink"] 

let tower = Scenario.make_scenario "tower" 
    "~It is basically a tradition to climb all 161 steps to the top of McGraw \
    ~Tower. Who knows when you'll even happen to be in Ithaca again; plus the \
    ~views would be amazing. Would you like to climb the tower?" 
    ["Too many steps"; "Yes views"]

let charlie = Friend.make_friend "Charlie" 5 

let lirinda = Friend.make_friend "Lirinda" 5 

let student_tests = [
  update_student_test "Changing one attribute (morality)" student_a 4.0 0.0 0.0 
    0.0 0.0 [] "" student_b;
  update_student_test "Testing adding a friend" student_b 0.0 0.0 0.0 0.0 0.0 
    [friend_a] "" student_c;
  update_student_test "Changing lots of attributes" student_c 6.0 3.0 8.0 40.0 
    10.5 [friend_a] "" student_d;

  give_money_test "give money: student has 3.0 more brbs" student_a 
    student_give_money;

  update_age_test "age should increase by 1" student_a student_age;

  update_friend_list_only_test "two friends" student_a [friend_a; friend_b]
    student_friends;

  check_decisions_test "Double in choices" "Double" student_a_check_decisions 
    true;
  check_decisions_test "single not in choices" "Single" 
    student_a_check_decisions false;

]

let friend_tests = [
  update_friend_test "update closeness only" friend_a 4 friend_a_updated;

  update_friend_test "don't update either attribute" friend_a 0 friend_a;

]

let scenario_tests = [
  return_consequences_test "first choice" "single" ["double"; "single"] 
    student_a [("gpa", 0.2)];

  return_consequences_error_test "choice not in choice list" "outside" 
    ["double"; "single"] student_a (InvalidInput "outside");

  return_scenario_name_test "name of starting scenario" 
    Scenario.starting_scenario "fresh start";

  return_scenario_name_test "name of second scenario" 
    Scenario.meet_brad "Meet Brad";

  return_scenario_name_test "name of third scenario" 
    Scenario.roommate_and_brad "Roommate and Brad";

  return_scenario_name_test "name of alternative third scenario" 
    Scenario.no_roommate_and_brad "No Roommate and Brad";

  return_scenario_name_test "name of fourth scenario" 
    Scenario.first_day "First Day";

  return_scenario_name_test "name of fifth scenario" 
    Scenario.clubfest "Clubfest";

  return_choices_test "choices for first scenario" Scenario.starting_scenario
    ["double"; "single"];

  return_choices_test "choices for second scenario" Scenario.meet_brad
    ["O Week"; "Stay in"; "Look at textbook"];

  return_choices_test "choices for third scenario" Scenario.roommate_and_brad
    ["Help them home"; "Leave without them"];

  return_choices_test "choices for alternative third scenario"
    Scenario.no_roommate_and_brad ["Help them home"; "Leave without them"];

  return_choices_test "choices for fourth scenario" Scenario.first_day
    ["Snooze"; "Go to class"];

  return_choices_test "choices for fifth scenario" Scenario.clubfest
    ["Fun Club"; "Career Club"; "Charity Club"];

  check_prereq_test "had prereq" roommate_and_brad 
    ("double", "No Roommate and Brad");

  check_prereq_test "had prereq 2" love 
    ("spend it with them", "junior slope day");

  check_prereq_test "had prereq 3" startup 
    ("career club", "grad school");

  check_prereq_test "no prereq" grad_school ("NOT IN HERE", "");

  check_prereq_test "no prereq 2" wines ("NOT IN HERE", "");

  check_prereq_test "no prereq 3" tower ("NOT IN HERE", "");

  go_through_unlocks_test "Is in list" Storage.unlock_list "love" 
    ("spend it with them", "junior slope day");

  go_through_unlocks_test "Is in list 2" Storage.unlock_list "Roommate and Brad" 
    ("double", "No Roommate and Brad");

  go_through_unlocks_error_test "Is not in list" Storage.unlock_list "wines"
    (InvalidInput "wines");

  go_through_unlocks_error_test "Is not in list" Storage.unlock_list "tower"
    (InvalidInput "tower");

  main_friend_function_test "Gain friend" "GET THEIR SNAP" [charlie];

  main_friend_function_test "Gain friend 2" "FUN CLUB" [lirinda];

  main_friend_function_test "Don't gain friend" "SINGLE" [];

  main_friend_function_test "Don't gain friend 2" "SNOOZE" [];
]

let scrambler_tests = [
  scramble_engine_test "Input = Word" "cornell" "cornell" "Correct!";
  scramble_engine_test "Input != Word" "cornell" "harvard" "Wrong!";
  scramble_engine_test "Uppercase Input = Word" "cOrNelL" "cornell" "Correct!";
  scramble_engine_test "Input = Uppercase Word" "cornell" "cOrNelL" "Correct!"
]

let minigames_tests = [
  make_list_of_strings_test "One word" "Hello" ["Hello"];
  make_list_of_strings_test "Two words" "Hello world" ["Hello"; "world"];
  make_list_of_strings_test "Longer phrase with punctuation" 
    "Hello world! It's so nice to meet you!!" ["Hello"; "world!"; "It's";
                                               "so"; "nice"; "to"; "meet"; 
                                               "you!!"];
  replace_in_lst_test "One element chars" ['1'] 0 '2' ['2'];
  replace_in_lst_test "One element ints" [1] 0 2 [2];
  replace_in_lst_test "Multiple elements strings" ["'0'"; "'1'"; "'2'"; "'3'"] 
    2 "'b'"   ["'0'"; "'1'"; "'b'"; "'3'"];
  replace_in_lst_test "Multiple elements nested list ints"
    [[1; 2]; [2]; [4;5]; [67;1;3;4]] 2 [6] [[1; 2]; [2]; [6]; [67;1;3;4]] ;
  replace_h_test "one char" ['a'] ['b'] 0 1 ['b'];
  replace_h_test "whole list" ['d';'o';'g']  ['c';'a'; 't'] 0 3 ['c';'a'; 't'];
  replace_h_test "starting in a later position" ['a'; 'b'; 'd';'o';'g']
    ['c';'a'; 't'] 2 3 ['a'; 'b'; 'c';'a'; 't'];
  replace_h_test "starting in a later position with things on the end"
    ['a'; 'b'; 'd';'o';'g'; 'c'; 'd'] ['c';'a'; 't']  2 3 
    ['a'; 'b'; 'c';'a'; 't'; 'c'; 'd'];
  rev_nested_lst_test "two elements" [[1; 2]; [3; 4]] [[1; 3]; [2; 4]];
  rev_nested_lst_test "one element" [[1]] [[1]];

]



let suite =
  "test suite for BIG RED REDEMPTION!"  >::: List.flatten [
    student_tests;
    scenario_tests;
    friend_tests;
    scrambler_tests;
    minigames_tests
  ]

let _ = run_test_tt_main suite