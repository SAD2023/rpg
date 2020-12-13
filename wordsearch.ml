(* open Graphics *)

let letters = ['a'; 'b'; 'c'; 'd'; 'e'; 'f'; 'g'; 'h'; 'i'; 'j'; 'k'; 'l';
               'm'; 'n'; 'o'; 'p'; 'q'; 'r'; 's'; 't'; 'u'; 'v'; 'w'; 'x';
               'y'; 'z']

let random_letter () = 
  List.nth letters (Random.int 25) 

let rec print_row lst =
  match lst with
  | [] -> print_endline ""
  | h :: t -> print_char h; print_row t

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
  while (n < List.length lst - 1) do
    if acc_counter.contents <> n then
      (acc_lst.contents <- (List.nth lst acc_counter.contents) :: acc_lst.contents;
       acc_counter.contents <- acc_counter.contents + 1)
    else
      (acc_lst.contents <- n :: acc_lst.contents;
       acc_counter.contents <- acc_counter.contents + 1)
  done;
  acc_lst.contents


(* let rec replace_h (init_lst : char list) (word_lst : char list) starting_pos length =
   let acc = ref 0 in
   let acc_lst = ref [] in
   (* let acc2 = ref length in *)
   while acc.contents < (starting_pos + length - 1) do
    if acc.contents < starting_pos then (
      acc_lst.contents <- acc_lst.contents @ [(List.nth init_lst acc.contents)];
      acc.contents <- acc.contents + 1)
    else 
      (acc_lst.contents <-
         replace_in_lst init_lst acc.contents
           (List.nth word_lst (acc.contents - starting_pos));
       acc.contents <- acc.contents + 1)
   done;
   acc_lst.contents

   let make_char_lst str=
   let acc = ref [] in
   String.iter (fun x -> acc.contents <- acc.contents @ [x]) str;
   acc.contents

   let rec make_grid_with_word_in_h word =
   let len = String.length word in
   let grid = make_grid (2 * len) in
   let start_pos_row = Random.int (len) in
   let start_pos_col = Random.int (2 * len) in
   let row = List.nth grid start_pos_col in
   let new_row = replace_h row (make_char_lst word) start_pos_row len in
   replace_in_lst grid start_pos_col new_row *)