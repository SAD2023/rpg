(** Wordsearch is a relatively simple minigame that asks the player to find a
    word hidden in a grid of random characters

    It will start by printing out a grid, and ask the player if they can find a 
    correct hidden word. If they can find it, then "Congratulations! 
    You got it!" will appear. Else, "That's not right! Try again" will be 
    visible and the player will be prompted to find the word again in the same
    word search game. This will continue until the player finds the correcct
    word.
*)


(** [main_wordsearch ()] will run one iteration of the wordsearch game. 
    It will print out a grid, and ask the player if they can find the 
    correct hidden word. If they can find it, then "Congratulations! 
    You got it!" will appear. Else, "That's not right! Try again" will be 
    visible and the player will be prompted to find the word again in the same
    word search game. This will continue until the player finds the correcct
    word. *)
val main_wordsearch: unit -> unit

(** [replace_in_lst lst n value] returns a new list which is an identical copy
    of lst, except that the nth value is replaced by value*)
val replace_in_lst: 'a list -> int -> 'a -> 'a list

(** [replace_h init_lst word_lst starting_pos length] returns a new list of
    characters that is an identical copy of the original, but with the chars
    in word_lst inserted starting at starting_pos *)
val replace_h: char list -> char list -> int -> int -> char list

(** [rev_nested_lst lst] takes a list of rows and columns and turns it into
    a new list of columns and rows *)
val rev_nested_lst: 'a list list -> 'a list list