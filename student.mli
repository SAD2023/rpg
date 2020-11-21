(**open Scenario*)

(** The abstract type of values representing the student*)
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

    Minimum of 0 and a maximum of 100. 
*)
type social_life = float


(** This is a reflection of how healthy a student is (mental and physical). 
    Increses when given a scenario and they choose the more healthy option 
    (e.g. working out) Decreases when given a scenario and they choose the less 
    healthy option (e.g. being on their laptop with junk food). Determines how 
    happy they are, future scenarios, and their endings.  

    Minimum of 0 and a maximum of 100. 
*)
type health = float

(** This shows how much a student is ballin. Increases when given a scenario
    and they pick the cheaper option (e.g. going to a dining hall and using
    swipes) and Decreases when given a scenario and they choose an option that 
    is more expensive or a waste of money (e.g. going to four seasons) 

    Minimum of 0 and a maximum of 100. 
*)
type brbs = float


(**  
   (** The abstract type of values representing friends (other characters)
 *)
   type friends = friend list

   (** The abstract type of values representing the decisions a student makes when
    given a certain scenario
 *)
   type decisions = Scenario.choice list 

*)

(** [decision] is the decision that the user makes during a given scenario.
*)
type decision = string

(** [initial name] takes in a name (a string) and creates a new student with 
    that name, plus default values of 0.0 for gpa, morality, brbs, health, 
    social_life, and 18 for the age*)
val initial : string -> student

(** [make_student] creates a new student with the given parameters, which are
    inputted by the user *)
val make_student : string -> int -> float -> float -> float -> float -> float -> Friend.friend list -> decision list -> student

(** [print_characteristics] prints out the characteristics (ex: gpa, morality,
    brbs, health etc) for a given student. *)
val print_characteristics : student -> unit

(** [update_student student morality gpa social_life health brbs] takes in
    a student and creates a new student with the previous student's attributes
    added to the attributes given. *)
val update_student : student -> float -> float -> float -> float -> float -> Friend.friend list -> decision -> student

(** [judgement student] takes in a student and prints out a string judging their 
    various attributes, depending on the actions that they have taken, and if they 
    are ethical or not *)
val judgement: student -> unit

val final_judgement: student -> unit

val return_decisions: student -> decision list

val check_decisions: decision -> student -> bool

val give_money: student -> student

val update_age: student -> student

val friend_list_getter: student -> Friend.friend list

val update_friend_list_only: student -> Friend.friend list -> student