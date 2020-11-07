(** [minigame] is the abstract type representing the various minigames that the 
    student will encounter throughout the game. The student will have the 
    choice whether or not they want to engage in the minigame. *)
type minigame

(** [name] is the name of the minigame. A valid name is a string that 
    contains A-Z, a-z, 0-9, and space characters. *)
type name = string

(** [rules] is the set of rules representing a given minigame. A valid
    set of rules contains A-z, a-z, 0-9, and space characters. *)
type rules = string

(** [correct_answer] is the abstract type representing the correct answer(s)
    of a given minigame. Based on the minigame, the type of correct_answer will
    vary. The student will have a chance of either choosing the correct 
    answer or not choosing the correct answer. *)
type correct_answer

(** [win] determines whether or not the student has won or has not won 
    the minigame. A valid won is represented as either true or false; true 
    indiating that the student has won the minigame or false indicating
    the student has not won the minigame. *)
type win = bool

val scramble_engine: string -> string -> string

val scramble_intro: string -> unit