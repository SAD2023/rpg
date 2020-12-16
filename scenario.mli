(**This is the abstract type representing different scenarios that the
   student is confronted with. *)
type scenario

(** This is the prompt that shows up when a student is given a certain scenario.
    It is a description of the event taking place. E.g. Brad asks you to hang 
    out on Saturday.
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

(** [meet_brad] is the second scenario in the game. *)
val meet_brad: scenario

(** [roommate_and_brad] is the third scenario in the game. *)
val roommate_and_brad: scenario

(** [no_roommate_and_brad] is the alternative third scenario in the game. *)
val no_roommate_and_brad: scenario

(** [first_day] is the fourth scenario in the game. *)
val first_day: scenario

(** [clubfest] is the fifth scenario in the game. *)
val clubfest: scenario

(** [print_prompt scenario] takes in a given scenario (in blue) and prints out
    the prompt and then prints out the choices (in yellow), separated by a new
    line each time *)
val print_prompt: scenario -> unit

(** [next_scenario decision] takes in a Student.decision and then prints out
    the next scenario that corresponds to it *)
val next_scenario: Student.decision -> choices -> Student.student -> scenario

(** [return_conseses decision] returns a list of the consequences (changes of 
    a player's attributes) based on the decision they made. If it is the end of
    the game, then "Your time at Cornell has come to an end. Goodbye! \n" is
    printed, and the game terminates *)
val return_consequences: Student.decision -> choices -> Student.student ->
  (string * float) list

(** [return_consequences student consequence_list] takes in a student and
    a list of (attribute * float) tuples. It then takes in the tuples that are
    changed (if any) and then returns a new studnet based on the changes*)
val match_consequences: Student.student -> (string * float) list ->
  Student.decision -> Student.student

(** [print_changes decision] takes in a given decision and prints the values
    of the changes to the terminal. *)
val print_changes: Student.decision -> choices -> Student.student -> unit

(**[return_choices scenario] returns the choices of a given scenario *)
val return_choices: scenario -> choices 

(** [main_friend_function decision] takes a decision string and returns a list
    with one friend instance, that is the friend that is gained in the given
    scenario *)
val main_friend_function: Student.decision -> Friend.friend list

(** [check_prereq scenario] checks to see if a student has made the required 
    choice to advance to a given scenario*)
val check_prereq: scenario -> string * string

(** [go_through_unlocks lst name] goes through a list and checks to see if the
    first element in one of the elements is equal to choice. If this is true, it 
    will return  the first element of the list. Otherwise, it will raise 
    InvalidException  *)
val go_through_unlocks: (choice * 'a) list -> choice -> 'a

(** [update_age scenario_name student] takes a scenario name and determines if
    it is one of the scenarios where the student has a birthday. If so, it
    returns a student identical to student, but with student.age as one year
    older, but if not, it just returns student. *)
val update_age: string -> Student.student -> Student.student

(** [return_scenario_name scenario] returns the name of the given scenario *)
val return_scenario_name: scenario -> string

(** [remove_friend name friend_list] Takes the name of a friend and a 
    friend_list and removes the friend with the name from the friend_list  *)
val remove_friend: string -> Friend.friend list -> Friend.friend list

val make_scenario: string -> prompt -> choice list -> hidden_choice list -> 
  scenario