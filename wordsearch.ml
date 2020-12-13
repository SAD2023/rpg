open Graphics

let letters = ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l';
               'm'; 'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x';
               'y'; 'z']

let word_lst = ["cookie"; "pizza"; "cake"; "pasta"; "candy"; "donut";
                "fries"; "oreo"; "cheese"; "apple"; "nugget"; "orange"]

let word_picker lst_of_words = 
  let index  = Random.int (List.length lst_of_words) in
  List.nth lst_of_words index 

let random_letter () = 
  List.nth letters (Random.int 25) 


(* Used for putting on the terminal, not needed for gui functionality *)
let rec print_row lst =
  match lst with
  | [] -> print_endline ""
  | h :: t -> print_char h; print_char ' '; print_row t

let rec print_nested_lst lst=
  match lst with
  | [] -> ()
  | h :: t -> print_row h; print_nested_lst t

let make_row len =
  let acc = ref [] in
  while List.length (acc.contents) < len do
    let new_char = random_letter () in
    acc.contents <- (new_char :: acc.contents)
  done;
  acc.contents

let rec make_grid len = 
  let acc = ref [] in
  while (List.length acc.contents) < len do
    let new_row = make_row len in
    acc.contents <- (new_row :: acc.contents)
  done;
  acc.contents

let replace_in_lst (lst : 'a list) n value =
  let acc_counter = ref 0 in
  let acc_lst = ref [] in
  while (acc_counter.contents < List.length lst) do
    if acc_counter.contents <> n then
      (acc_lst.contents <- ((List.nth lst acc_counter.contents) :: acc_lst.contents);
       acc_counter.contents <- (acc_counter.contents + 1))
    else
      (acc_lst.contents <- (value :: acc_lst.contents);
       acc_counter.contents <- acc_counter.contents + 1)
  done;
  acc_lst.contents


let rec replace_h (init_lst : char list) (word_lst : char list) starting_pos length =
  let acc = ref 0 in
  let acc_lst = ref [] in
  while acc.contents < (List.length init_lst) do
    if acc.contents < starting_pos then (
      acc_lst.contents <- acc_lst.contents @ [(List.nth init_lst acc.contents)];
      acc.contents <- acc.contents + 1)
    else if acc.contents > (starting_pos + length -1) then
      (acc_lst.contents <- acc_lst.contents @ [(List.nth init_lst acc.contents)];
       acc.contents <- acc.contents + 1)
    else 
      (acc_lst.contents <-
         acc_lst.contents @ 
         [List.nth word_lst (acc.contents - starting_pos)];
       acc.contents <- acc.contents + 1)
  done;
  acc_lst.contents

let make_char_lst str=
  let acc = ref [] in
  String.iter (fun x -> acc.contents <- acc.contents @ [x]) str;
  acc.contents

let make_grid_with_word_in_h word =
  let len = String.length word in
  let grid = make_grid (2 * len) in
  let start_pos_col = Random.int (len) in
  let start_pos_row = Random.int (2 * len) in
  let row = List.nth grid start_pos_row in
  let new_row = replace_h row (make_char_lst word) start_pos_col len in
  replace_in_lst grid start_pos_col new_row

(* let get_first_and_add_to_new_lst  *)




let rev_nested_lst lst =
  let acc_lst = ref [] in
  let elem = ref [] in
  for i = 0 to (List.length lst) - 1 do
    elem.contents <- []; 
    List.iter (fun x -> elem.contents <- elem.contents @ [List.nth x i]) lst;
    acc_lst.contents <- elem.contents :: acc_lst.contents 
  done;
  List.rev acc_lst.contents

let make_grid_with_word_in_v word =
  let grid = make_grid_with_word_in_h word in
  rev_nested_lst grid

let rec graph_print_row lst =
  match lst with
  | [] -> Gui.make_graph_addon (String.make 1 '~'); 
  | h :: t -> Gui.make_graph_addon_no_newline (String.make 1 h); 
    Gui.make_graph_addon_no_newline (String.make 1 ' '); 
    Gui.make_graph_addon_no_newline (String.make 1 ' '); 
    Gui.make_graph_addon_no_newline (String.make 1 ' '); 
    graph_print_row t

let rec graph_print_nested_lst lst=
  match lst with
  | [] -> ()
  | h :: t -> graph_print_row h; graph_print_nested_lst t

let rec main_wordsearch_engine_helper word=
  Gui.make_graph
    "Can you find the hidden word in this word search? \
     ~Type your guess and press '.' when you're done.~~"
    Graphics.red ;
  (if Random.bool () then 
     graph_print_nested_lst (make_grid_with_word_in_h word)
   else 
     (graph_print_nested_lst (make_grid_with_word_in_v word)));
  Gui.make_graph_addon "Guess a word: ";
  let guess = (Gui.type_out_string Graphics.yellow) in
  (if guess = word then
     Gui.make_graph_addon "Congratulations! You got it!"
   else
     (Gui.make_graph_addon "That's not right! Try again";
      main_wordsearch_engine_helper word))


let main_wordsearch ()=
  Graphics.open_graph "";
  Gui.make_graph "" Graphics.red;
  let word = word_picker word_lst in
  main_wordsearch_engine_helper word;

  (* Useful things for copy-pasting into terminal:
     export DISPLAY=:0

     #load "gui.cmo";;
     #use "wordsearch.ml";; (IN THAT ORDER)
  *)