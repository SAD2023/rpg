(** Hangman is a relatively simple minigame that asks the player to find an
    unknown word or phrase

    The player  has 10 lives and each time they guess a character or word 
    incorrectly, they lose a turn. The player is allowed to guess either a 
    character or word at each turn.
*)

(** [main_hangman ()] is the main engine for the hangman minigame. The player 
    has 10 lives and each time they guess a character or word incorrectly,
     they lose a turn. The player is allowed to guess either a character or 
     word at each turn.
*)
val main_hangman: unit -> unit

(** [make_list_of_strings phrase] makes a list with each element a different
    word in the list*)

val make_list_of_strings: string -> string list