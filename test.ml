open OUnit2
open Scenario
open Storage
open Student
open Friend


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

let friend_a = Friend.make_friend "kevin" 5 5
let friend_b = Friend.make_friend "joe" 5 5
let friend_c = Friend.make_friend "bob" 5 5

let student_a = Student.make_student "student" 18 0.0 0.0 0.0 0.0 0.0 [] []
let student_b = Student.make_student "student" 18 4.0 0.0 0.0 0.0 0.0 [] []
let student_c = Student.make_student "student" 18 4.0 0.0 0.0 0.0 0.0 
    [friend_a] []
let student_d = Student.make_student "student" 18 10.0 3.0 8.0 40.0 10.5 
    [friend_a; friend_b] []

let update_student_test name student morality gpa social_life health brbs 
    friends dec expected_output =
  name >:: (fun _ -> assert_equal expected_output 
               (Student.update_student student morality gpa social_life health 
                  brbs friends dec))

let student_tests = [
  update_student_test "Changing one attribute (morality)" student_a 4.0 0.0 0.0 
    0.0 0.0 [] "" student_b;
  update_student_test "Testing adding a friend" student_b 0.0 0.0 0.0 0.0 0.0 
    [friend_a] "" student_c;
  update_student_test "Changing lots of attributes" student_c 6.0 3.0 8.0 40.0 
    10.5 [friend_b] "" student_d;
]

let return_consequences_test name decision choices player expected_output  =
  name >:: fun ctxt -> assert_equal (cmp_set_like_lists (expected_output) 
                                       (Scenario.return_consequences decision 
                                          choices player)) true

let return_consequences_error_test name decision choices player expected_output  
  =
  name >:: fun ctxt -> assert_raises expected_output (fun () -> 
      (Scenario.return_consequences decision choices player))

let return_scenario_name_test name scenario expected_output = 
  name >:: fun ctxt -> assert_equal  (expected_output) 
      (Scenario.return_scenario_name scenario)

let return_choices_test name scenario expected_output = 
  name >:: fun ctxt -> assert_equal  (expected_output) 
      (Scenario.return_choices scenario)

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
    ["O Week"; "Stay in"; "Look at textbook"; "test"];

  return_choices_test "choices for third scenario" Scenario.roommate_and_brad
    ["Help them home"; "Leave without them"];

  return_choices_test "choices for alternative third scenario"
    Scenario.no_roommate_and_brad ["Help them home"; "Leave without them"];

  return_choices_test "choices for fourth scenario" Scenario.first_day
    ["Snooze"; "Go to class"];

  return_choices_test "choices for fifth scenario" Scenario.clubfest
    ["Fun Club"; "Career Club"; "Charity Club"];
]

let suite =
  "test suite for BIG RED REDEMPTION!"  >::: List.flatten [
    student_tests;
    scenario_tests;
  ]

let _ = run_test_tt_main suite