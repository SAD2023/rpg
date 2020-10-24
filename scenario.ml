open Storage 

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

let rec print_choices choices =
  match choices with 
  | [] -> ""
  | h :: t -> "\n -" ^ h ^ (print_choices t) 

let print_prompt scenario = 
  print_string (scenario.prompt ^ "\n" ^ (print_choices scenario.choices) ^ "\n")

let filter_helper a b = 
  String.uppercase_ascii a = String.uppercase_ascii (fst b)

let get_element_out_of_list list = 
  match list with 
  | [] -> assert false
  | h :: t -> h


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
    ["Fun Club"; "Career Club"; "Charitable Club"] []

let halloween = make_scenario "Halloween" "It’s Halloween! You want to go 
trick-or-treating, but you have a prelim the next morning. Do you…" 
    ["Go Trick-or-Treating"; "Study"] []

let club_meeting = make_scenario "Club Meeting" "Your club has a meeting! 
However, your friend invited you to go hiking. What do you do?" 
    ["Go to club meeting"; "Go hiking"] []


let scenario_list = [meet_brad; roommate_and_brad; no_roommate_and_brad;
                     first_day; clubfest; halloween; club_meeting]

let next_scenario decision = 
  let tuple_list = 
    List.filter (filter_helper decision) Storage.decision_scenario_name in
  let scenario_name = snd (get_element_out_of_list tuple_list) in
  let one_scenario_list = List.filter ( fun x -> x.name = scenario_name)
      scenario_list in 
  let next_scenario_element = get_element_out_of_list one_scenario_list in 
  next_scenario_element



