(** Representation of the Student (the player) and their various attributes

    This module represents the data stored for a given player, including the
    qualities GPA, morality, social life, health, brbs, age, and name, as well
    as containing some functions that judge the student depending on these 
    various qualities *)

(** [student] is the abstract type of values representing the student*)
type student

(** The age of the student. Starts at 18, and increments every year. *)
type age = int

(** The name of the student. User input*)
type name = string

(** The morality of a student. Starts as 0. Increses when given a scenario and
    they choose the more moral option. Decreases when given a scenario and
    they choose the less moral option. Determines their levels of friendships, 
    and ultimately their final job options. 

    Minimum of 0 and a maximum of 100. *)
type morality = float


(** The GPA of a student. Starts as 0. Increses when given a scenario and
    they choose an option that would imporve their grade in a class. Decreases
    when given a scenario and they choose an option that would decrease
    their grade in a class. Determines their ultimately their final 
    job options. 

    Minimum of 0.0 and a maximum of 4.0. *)
type gpa = float


(** This is a reflection of how social a student is. Increses when given a 
    scenario and they choose the more socail option (e.g. hanging out with 
    people) Decreases when given a scenario and they choose the less social 
    option (e.g. binging netflix by themselves). Determines their levels of 
    friendships, how many characters they meet and ultimately their final job 
    options.   

    Minimum of 0 and a maximum of 100. *)
type social_life = float


(** This is a reflection of how healthy a student is (mental and physical). 
    Increses when given a scenario and they choose the more healthy option 
    (e.g. working out) Decreases when given a scenario and they choose the less 
    healthy option (e.g. being on their laptop with junk food). Determines how 
    happy they are, future scenarios, and their endings.  

    Minimum of 0 and a maximum of 100. *)
type health = float

(** This shows how much a student is ballin. Increases when given a scenario
    and they pick the cheaper option (e.g. going to a dining hall and using
    swipes) and Decreases when given a scenario and they choose an option that 
    is more expensive or a waste of money (e.g. going to four seasons) 

    Minimum of 0 and a maximum of 100. *)
type brbs = float


(** This exception is raised if the student does not have enough BRBs *)
exception Poor of brbs


(** [decision] is the decision that the user makes during a given scenario. *)
type decision = string

(** [initial name] takes in a name (a string) and creates a new student with 
    that name, plus default values of 0.0 for gpa, morality, brbs, health, 
    social_life, and 18 for the age *)
val initial : string -> student

(** [make_student] creates a new student with the given parameters, which are
    inputted by the user *)
val make_student : string -> int -> float -> float -> float -> float -> float 
  -> Friend.friend list -> decision list -> student


(** [update_student student morality gpa social_life health brbs] takes in
    a student and creates a new student with the previous student's attributes
    added to the attributes given. *)
val update_student : student -> float -> float -> float -> float -> float -> 
  Friend.friend list -> decision -> student

(** [judgement student] takes in a student and prints out a string judging 
    their various attributes, depending on the actions that they have taken, 
    and if they are ethical or not *)
val judgement: student -> unit

(** [final_judgement student] takes in a student and prints out a string 
    judging their various final attributes, depending on the actions that they 
    have taken, and if they are ethical or not. It also determines their future 
    career. *)
val final_judgement: student -> unit

(** [return_decisions student] returns all of the decisions that a student has
    made. *)
val return_decisions: student -> decision list

(** check_decisions decision student returns true if the given decision is one
    that the student has made, and false if not *)
val check_decisions: decision -> student -> bool

(** [give_money student] returns a new student with the same qualities but with
    three more BRBs than the old student. *)
val give_money: student -> student

(** [update_age student] returns  new student with the same qualities but one 
    year older than the old student. *)
val update_age: student -> student

(** [friend_list_getter student] returns all of the friends that a student has
    made. *)
val friend_list_getter: student -> Friend.friend list

(** [update_friend_list_only student friends_list] returns a student identical
    to the previous student but with the friend list friends_list *)
val update_friend_list_only: student -> Friend.friend list -> student

(** [see_if_you_have_friend name student] checks to see if there exists a friend
    with [name] in the list of friends belonging to this [student], returning
    true if this friend exists in the list, and false otherwise *)
val see_if_you_have_friend: string -> student -> bool 