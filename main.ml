open Print
open Student
open Scenario
open Storage

(** [play_game f] starts the adventure in file [f]. *)
let rec play_game player scenario acc =
  (** 1. print prompt
      2. take input based on scenario
      3. update student based on input
      4. recall itself *)
  if (acc mod 3) = 2 then Student.judgement player;
  Scenario.print_prompt scenario;
  let lower_choices = Scenario.return_choices scenario in
  let choices = List.map String.uppercase_ascii lower_choices in 
  let (decision: Student.decision) = String.uppercase_ascii (read_line ()) in 

  try 
    let player = Scenario.match_consequences player (return_consequences decision choices player) decision in 
    let next_scenario = Scenario.next_scenario decision choices in 
    Scenario.print_changes decision choices player;
    play_game player next_scenario (acc+1)

  with InvalidInput decision -> ANSITerminal.(print_string [red] "\n Oops, wrong input playa. Please enter a valid choice \n \n");
    play_game player scenario acc



let main () =
  ANSITerminal.(print_string [red] (
      "\n
      Welcome to BIG RED REDEMPTION! Oh look.. a cs student! .. ew.."));
  ANSITerminal.(print_string [green] (
      "\n
      You're about to start your college life! From now on, you make your own 
      decisions and your decisions have consequences! 

      People will judge you on the following qualities: 

      Morality: how ethical you are. 

      Social Life: how smashed you get on the weekends 

      Health: what is a broccoli? Have you seen it? 

      BRBS: do you own a canada goose jacket and a gucci belt? 

      And most importantly, GPA: your entire self-worth, basically. \n
      "));
  ANSITerminal.(print_string [blue] "What's your name kid?\n");
  print_string  "\n > ";
  let player = Student.initial (read_line ()) in
  play_game player Scenario.starting_scenario 0


let () = main ()

