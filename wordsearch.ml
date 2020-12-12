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
    acc.contents = (new_char :: acc.contents)
  done;
  acc.contents

let rec make_grid len = 
  let acc = ref [] in
  while (List.length acc.contents) < len do
    let new_row = make_row len in
    acc.contents = (new_row :: acc.contents)
  done;
  acc.contents
