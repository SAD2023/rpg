open Storage 
open Friend

let jack = make_friend "Jack" 0 0

exception Unimplemented 
let potential_friend_list = []  

let new_friend_finder = function
  | [] -> jack
  | h :: t -> h 

type prompt = string
type choice = string
type hidden_choice = choice
type choices = choice list
type hidden_choices = hidden_choice list

exception InvalidInput of choice

type scenario = {
  name: string;
  prompt: prompt;
  choices: choice list;
  hidden_choices : hidden_choice list;
}



(**TODO *)
(** [match_input_to_input] matches a user's input; if it matches a valid
    decision pertaining to the given scenario, then it is a valid input but 
    if it isn't valid, it raises an exception. *)
let rec match_input_to_choice choices input =
  match choices with 
  | [] -> raise (InvalidInput input)
  | h :: t -> if h = input then h else match_input_to_choice t input


let starting_scenario = {
  name = "fresh start";
  prompt = "You are about to move into the low rises. Make sure you're ready 
  for a riot. Stay strapped at all times. Do you want a single or double?";
  choices = ["double"; "single"];
  hidden_choices = ["Triple"; "Live with happy dave"];
}

type next_scenarios = scenario list

(** [print_choices] prints the choices pertaining to a given scenario to 
    the terminal. *)
let rec print_choices choices =
  match choices with 
  | [] -> ""
  | h :: t -> "\n -" ^ h ^ (print_choices t) 


let return_choices scenario = 
  scenario.choices

(** [print_prompt] prints the prompt pertaining to a given scenario to 
    the terminal. *)
let print_prompt scenario = 
  ANSITerminal.(print_string [blue] (scenario.prompt ^ "\n")); 
  ANSITerminal.(print_string [yellow] (print_choices scenario.choices ^ "\n"))

(**[filter_helper] is a helper function to filter. *)
let filter_helper a b = 
  String.uppercase_ascii a = String.uppercase_ascii (fst b)

(** [get_element_out_of_list] exerts the head of a list; if the list 
    is empty, an exception is raised. *)
let get_element_out_of_list list = 
  match list with 
  | [] -> raise (InvalidInput "Wrong input")
  | h :: t -> h

(** [make_scenario] takes in types name, prompt, choices, and hidden_choices
    and produces a new scenario type. *)
let make_scenario name prompt choices hidden_choices =
  {
    name = name;
    prompt = prompt;
    choices = choices;
    hidden_choices = hidden_choices;
  }


let meet_brad =  make_scenario "Meet Brad" "You’re doing laundry for the first time 
and  you start talking to Brad, who lives  down the hall. He asks if you want 
to go to an O-Week event with him and some friends. What do you want to do?" 
    ["O Week"; "Stay in"; "Look at textbook"] []

let roommate_and_brad = 
  make_scenario "Roommate and Brad" "Your roommate comes with you, but 
  unfortunately needs a little help going home..." 
    ["Help them home"; "Leave without them"] []

let no_roommate_and_brad = 
  make_scenario "No Roommate and Brad" "You see someone (Aquinas) and they 
   seem very lost. Do you help them or stay with Brad and see if they can find 
   their way by themselves?" ["Help them home"; "Leave without them"] []


let first_day = make_scenario "First Day" "It’s the first day of classes! 
Your alarm buzzes  WAAAY too early. Do you snooze or go to your first class?" 
    ["Snooze"; "Go to class"] []

let clubfest = 
  make_scenario "Clubfest" "It’s Clubfest! Choose a club and decide whether 
    or not you actually show up to the first meeting here:" 
    ["Fun Club"; "Career Club"; "Charity Club"] []

let halloween = make_scenario "Halloween" "It’s Halloween! You want to go 
trick-or-treating, but you have a prelim the next morning. Do you…" 
    ["Go Trick or Treating"; "Study"] []

let club_meeting = make_scenario "Club Meeting" "Your club has a meeting! 
However, your friend invited you to go hiking. What do you do?" 
    ["Go to club meeting"; "Go hiking"] []


(** List of all the scenarios *)
let scenario_list = [meet_brad; roommate_and_brad; no_roommate_and_brad;
                     first_day; clubfest; halloween; club_meeting]

(** [next_scenario decision] takes in a Student.decision and then prints out
    the next scenario that corresponds to it *)
let next_scenario decision choices = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_scenario_name in
    let scenario_name = snd (get_element_out_of_list tuple_list) in
    let one_scenario_list = List.filter ( fun x -> x.name = scenario_name)
        scenario_list in 
    let next_scenario_element = get_element_out_of_list one_scenario_list in 
    next_scenario_element 
  else raise (InvalidInput decision)


let return_consequences decision choices = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_consequence_list in 
    let consequence_list =  snd (get_element_out_of_list tuple_list) in
    if fst (get_element_out_of_list consequence_list) = "end" then  
      (ANSITerminal.(print_string [magenta] "Your time at Cornell has come to an end. Goodbye! \n");
       exit 0) else  
      consequence_list
  else raise (InvalidInput decision)

(**[tuple_helper] is a helper function that extracts the second value of
   the tuple of (attribute, change in attribute) to determine by how much to
   change an atrribute(s) when updating the student. *)
let rec tuple_helper attribute tuple_list = 
  match tuple_list with 
  | [] -> 0.0
  | h :: t -> if fst h = attribute then snd h else tuple_helper attribute t 

let match_consequences student consequence_list = 
  let gpa = tuple_helper "gpa" consequence_list in 
  let morality = tuple_helper "morality" consequence_list in
  let brbs = tuple_helper "brbs" consequence_list in
  let health = tuple_helper "health" consequence_list in
  let social_life = tuple_helper "social_life" consequence_list in
  let friend = new_friend_finder potential_friend_list in 
  Student.update_student student morality gpa social_life health brbs friend

(** [change_tuple_helper] returns " increased by "  if the second value in
    a given tuple is positive, else returns " decreased by "  *)
let change_tuple_helper tuple =
  if snd tuple > 0. 
  then " increased by " 
  else " decreased by "

(** [print_tuple] prints a message to the user which indicates by how much 
    an atrribute of theirs has changed given the tuple of 
    (attribute, change in attribute). *)
let print_tuple tuple =  
  if fst tuple = "gpa" then
    " \n Your " ^ fst tuple ^ change_tuple_helper tuple ^ string_of_float (snd tuple) ^ "!! 
  \n" 
  else
    " \n Your " ^ fst tuple ^ change_tuple_helper tuple ^ 
    string_of_int (abs (int_of_float (snd tuple))) ^ "!! 
  \n" (* Prints an int so that there is no situation when it would print
         out "Your social life changed by 5.!!" with a period and then exclamation 
         points which looks weird *)

(** [map_print_helper] is a helper function to print_changes which takes
    in a string list and prints out all of the values in the list.*)
let rec map_print_helper string_list = 
  match string_list with 
  | [] -> ()
  | h :: t -> print_string h; map_print_helper t 

let print_changes decision choices = 
  let consequence_list = return_consequences decision choices in 
  let string_list = List.map print_tuple consequence_list in 
  map_print_helper string_list

