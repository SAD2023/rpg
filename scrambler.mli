(** Scrambler is a very simple minigame that prints out a word arranged in a
    random order, and then asks the player to unscramble it *)

(** [scramble_engine] takes in a word and a user's input and checks to see
    if the user's input correctly matches the word. *)
val scramble_engine: string -> string -> string

(** [scramble_intro] prints the introduction/instructions for the scramble
    minigame.*)
val scramble_intro: string -> unit

(** [play_minigame student acc] plays the scrambler minigame *)
val play_minigame: Student.student -> int -> Student.student * int