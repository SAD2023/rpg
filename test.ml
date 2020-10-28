open OUnit2
open Scenario
open Storage
open Student
open Friend

(**Mohammed, Nicola *)
let student_tests = [


]

(**Sadman, Lirinda *)
let scenario_tests = [


]



let suite =
  "test suite for BIG RED REDEMPTION!"  >::: List.flatten [
    student_tests;
    scenario_tests;
  ]

let _ = run_test_tt_main suite