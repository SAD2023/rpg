open Print
open Student
open Scenario
open Storage
open Minigames


let word_to_scramble = "cornell"
let words_to_scramble = ["cornell"; "clocktower"; "happydave"; "touchdown"; "slope"; "beebeelake"; 
                         "chimes"; "uris"; "duffield"; "clarkson"; "OCaml";]

let word_picker lst_of_words = 
  let index  = Random.int (List.length lst_of_words) in
  List.nth lst_of_words index 


let rec print_list lst = 
  match lst with 
  | [] -> ""
  | h :: t -> h ^ ", " ^ print_list t 

let give_number letter = 
  if letter = "A" then 0 
  else if letter = "B" then 1 
  else if letter = "C" then 2
  else if letter = "D" then 3 
  else 4


(** [play_game f] keeps the game playing. *)
let rec play_game player scenario acc =
  (** 1. print prompt
      2. take input based on scenario
      3. update student based on input
      4. recall itself *)
  let player = Scenario.update_age (Scenario.return_scenario_name scenario) player in
  if (acc mod 3) = 2 then Student.judgement player;
  if (acc mod 25) = 20 then (let word =  word_picker words_to_scramble  in 
                             (Minigames.scramble_intro word); 
                             let input = (read_line ()) in begin 
                               if Minigames.scramble_engine word input = "Wrong!" then
                                 (print_string "\n WRONG! Let's try a different word...\n"; 
                                  play_game player scenario acc) 
                               else print_string "\n Correct! Hurray! You get 3 bucks! \n\n"; 
                               let player = Student.give_money player in play_game player scenario (acc+1) 
                             end); 
  Scenario.print_prompt scenario;
  let lower_choices = Scenario.return_choices scenario in
  let choices = List.map String.uppercase_ascii lower_choices in 
  try 
    let (decision: Student.decision) = List.nth choices (give_number(String.uppercase_ascii (read_line ()))) in 
    let player = Scenario.match_consequences player (return_consequences decision choices player) decision in 
    let next_scenario = Scenario.next_scenario decision choices player in 
    Scenario.print_changes decision choices player; (*
   print_string(print_list (Student.return_decisions player)); *)
    play_game player next_scenario (acc+1)

  with Failure(string) ->
    ANSITerminal.(print_string [red] "\n Oops, wrong input playa. Please enter a valid choice \n \n");
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

