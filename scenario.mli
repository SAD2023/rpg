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


val starting_scenario: scenario

val print_prompt: scenario -> unit

val next_scenario: Student.decision -> scenario