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

val make_graph_addon_no_newline: ?color:Graphics.color -> string -> unit

(**[make_final_judgement_graph_addon] takes in a color and a string and 
   inserts the string to the existing gui graph by altering the coordinates. 
   This displays the final judgement of the user based on the user's choices.*)
val make_final_judgement_graph_addon: ?color:Graphics.color ->  string -> unit

val type_word: string -> unit

val make_graph_scenario: string -> string list -> unit

val type_out_string: Graphics.color -> string

val type_out_unscrambled: unit -> string

val type_out_choice: char -> unit