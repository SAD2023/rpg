(**This is the abstract type representing different scenarios that the
   student is confronted with. *)
type scenario

(** This is the prompt that shows up when a student is given a certain scenario.
    It is a description of the event taking place. E.g. Brad asks you to hang out
    on Saturday.
*)
type prompt = string

(** An instance of a choice that a student can take. E.g. You choose to hang
    out with Brad. Printed out with the prompt. 
*)
type choice = string

(** Similar to a normal 'choice' but it is not printed out. It can be accessed
    by a player if they type it in, but it would not be shown with the prompt *)
type hidden_choice = choice

(**This is a list of choice instances. Includes all of the choices the player/
   student can take.
*)
type choices = choice list

(**This is a list of hidden_choice instances. Includes all of the hidden 
   choices the player/student can take.
*)
type hidden_choices = hidden_choice list

(** This is a list of scenario instances. It includes all of the potential 
    scenarios that may arise from this current scenario. 

    E.g. after you are given a scenario with the [prompt] of Brad asking to 
    hang out with you, next potential scenarios may have the [prompt] of: Brad 
    asking you to join a club he's in (if you chose to hang out with Brad) or 
    your roommate asking you to go watch a movie with them (if you didn't hang 
    out with Brad and instead went on a hike with your roommate.)
*)
type next_scenarios = scenario list

(**This exception is raised when a player inputs a choice that is invalid,
   i.e. not contained within choices or hidden_choices. 
*)
exception InvalidInput of choice

(** [starting_scenario] is just the first scenario in the game. The player 
    has just moved into the low rises and needs to choose a roommate*)
val starting_scenario: scenario

(** [print_prompt scenario] takes in a given scenario (in blue) and prints out the
    prompt and then prints out the choices (in yellow), separated by a new
    line each time *)
val print_prompt: scenario -> unit

(** [next_scenario decision] takes in a Student.decision and then prints out
    the next scenario that corresponds to it *)
val next_scenario: Student.decision -> choices -> scenario


(** [return_conseses decision] returns a list of the consequences (changes of 
    a player's attributes) based on the decision they made. If it is the end of
    the game, then "Your time at Cornell has come to an end. Goodbye! \n" is
    printed, and the game terminates *)
val return_consequences: Student.decision -> choices -> (string * float) list

(** [return_consequences student consequence_list] takes in a student and
    a list of (attribute * float) tuples. It then takes in the tuples that are
    changed (if any) and then returns a new studnet based on the changes*)
val match_consequences: Student.student -> (string * float) list -> Student.student


(** [print_changes decision] takes in a given decision and prints the values
    of the changes to the terminal. *)

val print_changes: Student.decision -> choices -> unit

(**Returns the choices of a given scenario *)
val return_choices: scenario -> choices 