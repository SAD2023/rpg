(** [set_background] sets up the background of the gui graph by clearing the 
    existing graph and setting the colors of the background. *)
val set_background: unit -> unit

(** [print_graph_choices] takes in the choice list of a given scenario and 
    formats them on the gui graph by setting the coordinates and colors of
    each choice. *)
val print_graph_choices: string list -> unit

(** [make_graph] sets the new gui graph for every input the user makes
    (for every new scenario, minigame, etc.); resets the coordinates and colors 
    and inserts the new contents of the graph.*)
val make_graph: string -> Graphics.color -> unit

(**[make_graph_addon] takes in a color and a string and inserts the string
   to the existing gui graph by altering the coordinates.*)
val make_graph_addon: ?color:Graphics.color ->  string -> unit

(** [make_graph_addon_no_newline] *)
val make_graph_addon_no_newline: ?color:Graphics.color -> string -> unit

(**[make_final_judgement_graph_addon] takes in a color and a string and 
   inserts the string to the existing gui graph by altering the coordinates. 
   This displays the final judgement of the user based on the user's choices.*)
val make_final_judgement_graph_addon: ?color:Graphics.color ->  string -> unit

(**[type_word] takes in a string word, sets the background, text color, and 
   moves the coordinates to print the string onto the gui display. *)
val type_word: string -> unit

(** [make_graph_scenario] takes in a scenario and the choices list and 
    displays them on the gui display by resetting the coordinates to display
    the scenario and choices properly. *)
val make_graph_scenario: string -> string list -> unit

(** [type_out_string] takes in a color and sets the color of the text and 
    takes in the user's input and updates the contents accordingly.*)
val type_out_string: Graphics.color -> string

(** [type_out_unscrambled] displays the string "Your Answer: " and has an
    accumulator value which is updated based on the contents of the user's
    input. *)
val type_out_unscrambled: unit -> string

(** [type_out_choice] displays the user's answer choice on the screen and 
    keeps the current screen on for a small while before updating the screen 
    to the next scenario. *)
val type_out_choice: char -> unit