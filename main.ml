open Print
open Student
open Scenario
open Storage

(** [play_game f] starts the adventure in file [f]. *)
let rec play_game player scenario =
  (** 1. print prompt
      2. take input based on scenario
      3. update student based on input
      4. recall itself *)
  Scenario.print_prompt scenario;
  let (decision: Student.decision) = String.uppercase_ascii (read_line ()) in 
  let player = Scenario.match_consequences player (return_consequences decision) in 
  let next_scenario = Scenario.next_scenario decision in 
  Scenario.print_changes decision;
  play_game player next_scenario






let main () =
  print_string
    "\n\nWelcome to BIG RED REDEMPTION! Oh look.. a cs student! .. ew..\n";
  print_endline "What's your name kid?\n";
  print_string  "\n > ";
  let player = Student.initial (read_line ()) in
  play_game player Scenario.starting_scenario


let () = main ()

