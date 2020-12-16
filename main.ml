open Print
open Student
open Scenario
open Storage
open Scrambler
open Graphics
open Gui 
open Unix
open Hangman
open Wordsearch


let give_number letter = 
  if letter = "A" then 0 
  else if letter = "B" then 1 
  else if letter = "C" then 2
  else if letter = "D" then 3 
  else 4



(** [play_game f] keeps the game playing. *)
let rec play_game player scenario acc =
  let player = Scenario.update_age (Scenario.return_scenario_name scenario) 
      player in 
  play_minigames player scenario acc;
  Scenario.print_prompt scenario;
  let lower_choices = Scenario.return_choices scenario in
  let choices = List.map String.uppercase_ascii lower_choices in 
  try try_statement player choices acc
  with | Failure(string) -> 
    Gui.make_graph "Oops, wrong input playa. Please enter a valid choice" 
      Graphics.red;
    Unix.sleep 2;
    play_game player scenario acc
       | Student.Poor(float) ->
         Gui.make_graph 
           "Oops, you're too poor. Please enter a valid choice poor person :/ " 
           Graphics.green;
         Unix.sleep 2;
         play_game player scenario acc

(** [play_minigames player scenario acc] will have the player play a minigame
    every ten scenarios*)
and play_minigames player scenario acc =
  if (acc mod 15) = 5 then (Student.judgement player;
                            Unix.sleep 5);
  if (acc mod 30) = 9 then (let player_mini, acc_mini = 
                              Scrambler.play_minigame player acc in
                            play_game player_mini scenario acc_mini); 
  if (acc mod 30) = 19 then main_hangman (); 
  if (acc mod 30) = 29 then main_wordsearch ()

and try_statement player choices acc=
  let user_choice = Graphics.read_key () in 
  Gui.type_out_choice user_choice;
  let (decision: Student.decision) = List.nth choices 
      (give_number(String.uppercase_ascii (String.make 1 (user_choice)))) in 

  let player = Scenario.match_consequences player 
      (return_consequences decision choices player) decision in 
  let next_scenario = Scenario.next_scenario decision choices player in 
  Scenario.print_changes decision choices player; 
  play_game player next_scenario (acc+1)

let main () =
  Graphics.open_graph "";

  Gui.make_graph " \
    ~Welcome to BIG RED REDEMPTION! Oh look.. a cs student! .. ew.." 
    Graphics.red;
  Gui.make_graph_addon
    "~You're about to start your college life! From now on, you make your own";
  Gui.make_graph_addon
    "~decisions and your decisions have consequences!";
  Gui.make_graph_addon
    "";
  Gui.make_graph_addon ~color:Graphics.red
    "~People will judge you on the following qualities: ";
  Gui.make_graph_addon ~color:Graphics.magenta
    "~ - Morality: how ethical you are.";
  Gui.make_graph_addon ~color:Graphics.cyan
    "~ - Social Life: how smashed you get on the weekends";
  Gui.make_graph_addon ~color:Graphics.yellow
    "~ - Health: what is a broccoli? Have you seen it?";
  Gui.make_graph_addon ~color:Graphics.green
    "~ - BRBS: do you own a canada goose jacket and a gucci belt?";
  Gui.make_graph_addon ~color:Graphics.blue
    "~ - And most importantly, GPA: your entire self-worth, basically.";
  Gui.make_graph_addon
    "";
  Gui.make_graph_addon
    "~What's your name kid?";
  Gui.make_graph_addon
    "~(Type in your name, make sure to end it with a period ('.'))";
  Gui.make_graph_addon
    "~Name: ";
  Graphics.set_color Graphics.white; 


  let name = Gui.type_out_string Graphics.yellow in 
  let player = Student.initial (name) in
  play_game player Scenario.starting_scenario 0

let () = main ()

