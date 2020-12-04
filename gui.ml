open Graphics

let abcde = ["A"; "B"; "C"; "D"; "E"]

let print_graph_choices choices = 
  let x = ref 300 in 
  let y = ref 375 in 
  for i = 0 to List.length choices - 1 do 
    y.contents <- y.contents - 50;
    let x1 = x.contents in let y1 = y.contents in 
    Graphics.moveto x1 y1;
    Graphics.set_color Graphics.black;
    Graphics.draw_ellipse x1 y1 200 20;
    Graphics.set_color Graphics.red;
    Graphics.fill_ellipse x1 y1 200 20;
    Graphics.set_color Graphics.black;
    let choice_size = fst (Graphics.text_size (List.nth choices i)) in 
    Graphics.moveto (x1 - (choice_size / 2 + 5)) (y1 - 5);
    Graphics.set_text_size 100;
    Graphics.draw_string ((List.nth abcde i) ^ ") " ^ (List.nth choices i));
  done

let make_graph word = 
  Graphics.clear_graph ();
  Graphics.set_color Graphics.black;
  Graphics.fill_rect 0 0 (Graphics.size_x ()) (Graphics.size_y ());
  Graphics.moveto 50 400;
  let x = ref 50 in 
  let y = ref 400 in 
  let word_list = String.split_on_char '~' word in 
  for i= 0 to List.length word_list - 1 do
    y.contents <- y.contents - 15;
    Graphics.moveto x.contents y.contents;
    Graphics.set_color Graphics.red;
    Graphics.draw_string (List.nth word_list i);
  done


let make_graph_scenario prompt choices= 
  Graphics.clear_graph ();
  Graphics.set_color Graphics.black;
  Graphics.fill_rect 0 0 (Graphics.size_x ()) (Graphics.size_y ());
  let x = ref 50 in 
  let y = ref 400 in 
  Graphics.moveto 50 400;
  let prompt_list = String.split_on_char '~' prompt in 
  for i= 0 to List.length prompt_list - 1 do
    y.contents <- y.contents - 15;
    Graphics.moveto x.contents y.contents;
    Graphics.set_color Graphics.white;
    Graphics.draw_string (List.nth prompt_list i);
  done;
  Graphics.set_color Graphics.white;
  Graphics.moveto 50 50;
  Graphics.draw_string "Your Choice: ";
  print_graph_choices choices

let type_out_string () = 
  let acc = ref "" in 
  let char = ref (Graphics.read_key ()) in 
  while char.contents <> '.' do  
    Graphics.draw_char char.contents;
    acc.contents <- acc.contents ^ String.make 1 char.contents;
    char.contents <- Graphics.read_key ()
  done;
  acc.contents

let type_out_choice user_choice =
  Graphics.set_color Graphics.white;
  Graphics.moveto 130 50;
  Graphics.draw_char (Char.uppercase_ascii user_choice);
  Unix.sleepf (0.5) 
(* DELETE THIS LATER IF WE DON'T NEED
    let rec get_string acc = 
    let status = Graphics.wait_next_event [Graphics.Key_pressed] in 
    if status.key = '.' then (acc) else get_string (acc ^ (String.make 1 (Graphics.read_key ()))) *)