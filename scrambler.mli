

(** [scramble_engine] takes in a word and a user's input and checks to see
    if the user's input correctly matches the word. *)
val scramble_engine: string -> string -> string

(** [scramble_intro] prints the introduction/instructions for the scramble
    minigame.*)
val scramble_intro: string -> unit

val play_minigame: Student.student -> int -> Student.student * int