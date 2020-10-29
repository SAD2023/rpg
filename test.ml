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

(**Mohammed, Nicola *)
let student_tests = [


]



let return_consequences_test name decision choices expected_output  =
  name >:: fun ctxt -> assert_equal (cmp_set_like_lists (expected_output) (Scenario.return_consequences decision choices)) true

let return_consequences_error_test name decision choices expected_output  =
  name >:: fun ctxt -> assert_raises expected_output (fun () -> (Scenario.return_consequences decision choices))

(**Sadman, Lirinda *)
let scenario_tests = [
  return_consequences_test "first choice" "single" ["double"; "single"] [("gpa", 0.2)];

  return_consequences_error_test "choice not in choice list" "outside" ["double"; "single"] (InvalidInput "outside");


]



let suite =
  "test suite for BIG RED REDEMPTION!"  >::: List.flatten [
    student_tests;
    scenario_tests;
  ]

let _ = run_test_tt_main suite