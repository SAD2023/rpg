open Print
open Student
open Scenario
open Storage
open Minigames
open Graphics
open Gui 
open Unix




(*1. Hangman
  2. tic tac toe
  3. cornell trivia
  4.  *)
let word_to_scramble = "cornell"
let words_to_scramble = ["cornell"; "clocktower"; "happydave"; "touchdown"; 
                         "slope"; "beebeelake"; 
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

let friend_minigame player = 
  let player_friend_list = Student.friend_list_getter player in 
  let lonely_list = List.filter (fun x -> Friend.get_closeness x < 1) 
      player_friend_list in  (*
  print_string (string_of_int (List.length lonely_list)); *)
  if List.length lonely_list > 0 then 
    let lonely_friend = List.hd lonely_list in 
    print_string ("\nYou haven't spent much time with your friend " ^ 
                  Friend.get_name (lonely_friend) ^ 
                  ". \nDo you want to play a quick game with them? \n\n
 A)Yes\n
 B)No \n\n");
    let input =  String.uppercase_ascii (read_line ()) in 
    if input = "A" || input = "YES" then 
      (print_string "How do you spell cornell? Hint: it's cornell \n";
       let input = String.uppercase_ascii (read_line ()) in 
       (begin if input = "CORNELL" then print_string 
             "\n WOW! Smartie Pants! \n\n"
         else print_string "\nEwww Dumbass \n\n" end);
       let friend = lonely_friend in 
       let name = Friend.get_name friend in   
       let updated_friend_list = Scenario.remove_friend name 
           (Student.friend_list_getter player) in 
       let updated_friend = Friend.update_friend friend 5 0 in 
       Student.update_friend_list_only player 
         (updated_friend :: updated_friend_list))
    else(
      let friend = lonely_friend in 
      let name = Friend.get_name friend in   
      let updated_friend_list = Scenario.remove_friend name 
          (Student.friend_list_getter player) in  
      let player = Student.update_friend_list_only player updated_friend_list in 
      (print_string ("You're no longer friends with " ^ Friend.get_name 
                       lonely_friend ^ ". Your current list of friends are: " ^
                     "\n\n"); 
       List.iter (fun x -> 
           print_string(Friend.get_name x)) (Student.friend_list_getter player)); 
      player)

  else player 

(** [play_game f] keeps the game playing. *)
let rec play_game player scenario acc =
  (** 1. print prompt
      2. take input based on scenario
      3. update student based on input
      4. recall itself *)
  let player = Scenario.update_age (Scenario.return_scenario_name scenario) 
      player in 
  (* let player = friend_minigame player in   *)
  if (acc mod 10) = 7 then (Student.judgement player;
                            Unix.sleep 5);
  if (acc mod 10) = 9 then (let word =  word_picker words_to_scramble in 
                            let result = Minigames.play_minigame word in begin
                              if result = "WRONG! Let's try a different word..." 
                              then play_game player scenario acc 
                              else let player = Student.give_money player in 
                                play_game player scenario (acc+1)                             
                            end);  
  Scenario.print_prompt scenario;
  let lower_choices = Scenario.return_choices scenario in
  let choices = List.map String.uppercase_ascii lower_choices in 
  try 
    let user_choice = Graphics.read_key () in 
    Gui.type_out_choice user_choice;
    let (decision: Student.decision) = List.nth choices 
        (give_number(String.uppercase_ascii (String.make 1 (user_choice)))) in 

    let player = Scenario.match_consequences player 
        (return_consequences decision choices player) decision in 
    let next_scenario = Scenario.next_scenario decision choices player in 
    Scenario.print_changes decision choices player; (*
   print_string(print_list (Student.return_decisions player)); *)
    play_game player next_scenario (acc+1)
  with | Failure(string) -> (*
    ANSITerminal.(print_string [red] "\n 
    Oops, wrong input playa. Please enter a valid choice \n \n"); *)
    Gui.make_graph "Oops, wrong input playa. Please enter a valid choice" Graphics.red;
    Unix.sleep 2;
    play_game player scenario acc
       | Student.Poor(float) ->
         Gui.make_graph "Oops, you're too poor. Please enter a valid choice poor person :/ " Graphics.green;
         Unix.sleep 2;
         play_game player scenario acc

let main () =
  Graphics.open_graph "";

  Gui.make_graph " \
    ~Welcome to BIG RED REDEMPTION! Oh look.. a cs student! .. ew.." Graphics.red;
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

