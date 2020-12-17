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
let friend_a_updated = Friend.make_friend "kevin" 9 5
let friend_a_updated_worth = Friend.make_friend "kevin" 5 9
let friend_a_both = Friend.make_friend "kevin" 9 9
let friend_b = Friend.make_friend "joe" 5 5

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

let update_friend_test name friend closeness worth expected_output =
  name >:: fun ctxt -> assert_equal (expected_output) 
      (Friend.update_friend friend closeness worth)

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

let roommate_and_brad = 
  Scenario.make_scenario "Roommate and Brad" 
    "Your roommate's friend comes with you, but unfortunately needs a little \
          ~help going home..." 
    ["Help them home"; "Leave without them"] []

let love = Scenario.make_scenario "love"
    "Oop, things seem to be getting serious <3. Would you like to make things\
   ~official with them ?"
    ["I'm falling for them"; "I have commitment issues"] []

let startup =  Scenario.make_scenario "startup" 
    "~Your friend Maximillian the III is making a startup as a side hustle. \
    ~Do you wanna be a part of it? It might take some time out of your semester\
    ~but it'll definitely look good on your resume."
    ["Startup"; "Meh. I would only work for Google"] []

let grad_school =  Scenario.make_scenario "grad school" 
    "~Grad school applications are starting to be due. Would you like to apply \
    ~to a grad school?"
    ["Grad school"; "Industry"] []

let wines = Scenario.make_scenario "wines" 
    "~It is your very last semester at Cornell!! This means that this is your \
    ~last chance to take any course before you leave. Everyone talks about \
    ~taking the wine course at Cornell. Shall we raise a glass?" 
    ["White wine please"; "I don't drink"] [] 

let tower = Scenario.make_scenario "tower" 
    "~It is basically a tradition to climb all 161 steps to the top of McGraw \
    ~Tower. Who knows when you'll even happen to be in Ithaca again; plus the \
    ~views would be amazing. Would you like to climb the tower?" 
    ["Too many steps"; "Yes views"] [] 

let charlie = Friend.make_friend "Charlie" 5 0

let lirinda = Friend.make_friend "Lirinda" 5 0 

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

  update_friend_list_only_test "two friends" student_a [friend_a; friend_b] student_friends;

  check_decisions_test "Double in choices" "Double" student_a_check_decisions true;
  check_decisions_test "single not in choices" "Single" student_a_check_decisions false;

]

let friend_tests = [
  update_friend_test "update closeness only" friend_a 4 0 friend_a_updated;

  update_friend_test "update worth only" friend_a 0 4 friend_a_updated_worth;

  update_friend_test "don't update either attribute" friend_a 0 0 friend_a;

  update_friend_test "update both closeness and worth" friend_a 4 4 friend_a_both;
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
    ["O Week"; "Stay in"; "Look at textbook"; "test"];

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





let suite =
  "test suite for BIG RED REDEMPTION!"  >::: List.flatten [
    student_tests;
    scenario_tests;
    friend_tests;
    scrambler_tests
  ]

let _ = run_test_tt_main suite