open Graphics


let make_graph word = 
  Graphics.open_graph "" ;
  Graphics.set_color Graphics.black;
  Graphics.moveto 100 100;
  Graphics.draw_string word;

