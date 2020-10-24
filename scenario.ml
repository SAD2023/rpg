
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
  for a riot. Stay strapped at all times. Do you want a roommate?";
  choices = ["Yes"; "Nah"];
  hidden_choices = ["Triple"; "Live with happy dave"];
}

type next_scenarios = scenario list

let rec print_choices choices =
  match choices with 
  | [] -> ""
  | h :: t -> "\n -" ^ h ^ (print_choices t) 

let print_prompt scenario = 
  print_string (scenario.prompt ^ "\n" ^ (print_choices scenario.choices))