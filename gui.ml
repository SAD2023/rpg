open Graphics

let print_graph_choices choices = 
  let x = ref 300 in 
  let y = ref 400 in 
  for i = 0 to List.length choices - 1 do 
    y.contents <- y.contents - 50;
    let x1 = x.contents in let y1 = y.contents in 
    Graphics.moveto x1 y1;
    Graphics.draw_ellipse x1 y1 200 20;
    Graphics.set_color Graphics.green;
    Graphics.fill_ellipse x1 y1 200 20;
    Graphics.set_color Graphics.black;
    let choice_size = fst (Graphics.text_size (List.nth choices i)) in 
    Graphics.moveto (x1 - (choice_size / 2)) (y1 - 5);
    Graphics.set_text_size 100;
    Graphics.draw_string (List.nth choices i);

  done

let make_graph word = 
  Graphics.clear_graph ();
  Graphics.moveto 50 400;
  Graphics.draw_string word

let make_graph_scenario prompt choices= 
  Graphics.clear_graph ();
  Graphics.moveto 50 400;
  Graphics.draw_string prompt;
  print_graph_choices choices

