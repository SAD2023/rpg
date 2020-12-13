(* open Gui *)
open Graphics

let hangman_words = ["this game sucks"; "cornell"; "peace love and ocaml";
                     "goodbye ocaml programmers"; "stupid ocaml syntax";
                     "let me put this in utop"; "ill let you think about it"; 
                     "this is 3110"; "jump off a bridge"; 
                     "send me a screenshot"; "DON'T CROP"]

let make_list_of_strings phrase = 
  String.split_on_char ' ' phrase

let format char phrase acc so_far=    
  for i =0 to String.length phrase -1 do
    if String.get phrase i = char then acc.contents <- acc.contents ^ (String.make 1 char) else
    if String.get so_far i <> '*' then acc.contents <- acc.contents ^ (String.make 1 (String.get so_far i)) else
      acc.contents <- acc.contents ^ "*"
  done; 
  let value = acc.contents in
  acc.contents <- "";
  value

let rec string_of_char_list lst  =
  match lst with
  | [] -> ""
  | h :: t -> (String.make 1 h) ^ ", " ^ string_of_char_list t 

let rec main_hangman_helper letters_guessed word guesses_left acc=
  if guesses_left = 0 then 
    Gui.make_graph_addon ("You lose :-(, the correct word was: " ^ word)
  else
    (Gui.make_graph "Let's play hangman! Can you guess the word?" Graphics.red;

     Gui.make_final_judgement_graph_addon  
       ("~Guesses left: " ^ string_of_int guesses_left ^
        "~Guesses so far: " ^ acc ^
        "~Letters guessed so far: " ^ 
        (string_of_char_list 
           (List.sort_uniq compare letters_guessed)) ^ 
        "~Guess a letter or word and then press '.': "));

  let guess = (Gui.type_out_string Graphics.yellow) in
  let empty = ref "" in
  if String.length guess = 1 then
    let chara = (String.get guess 0) in
    begin 
      if List.mem chara letters_guessed then
        (let astrisks = (format chara word empty acc) in
         Gui.make_graph_addon
           "You have already guessed this letter. Please try again!";
         main_hangman_helper (letters_guessed) word (guesses_left) astrisks)

      else if String.contains word chara then 
        let astrisks = (format chara word empty acc) in
        begin
          if String.contains astrisks '*' = false then
            Gui.make_graph_addon 
              "Congratulations! You guessed the word correctly!"    
          else 
            (Gui.make_graph_addon ("Correct letter! You have " ^
                                   (string_of_int (guesses_left )) 
                                   ^ " guesses left");
             let astrisks = (format chara word empty acc) in
             Gui.make_graph_addon  astrisks;
             main_hangman_helper (chara :: letters_guessed) word (guesses_left) astrisks)
        end
      else
        (Gui.make_graph_addon  ("Wrong letter! You have " ^
                                (string_of_int (guesses_left-1)) ^ " guesses left");
         let astrisks = (format chara word empty acc) in
         Gui.make_graph_addon  astrisks;
         main_hangman_helper (chara :: letters_guessed) word (guesses_left - 1) astrisks)
    end
  else if guess = word then 
    (Gui.make_graph_addon  "Congratulations! You guessed the word correctly!";)
  else begin
    Gui.make_graph_addon  "That is not the correct word. Try again";
    main_hangman_helper letters_guessed word (guesses_left - 1) acc
  end



let word_picker lst_of_words = 
  let index  = Random.int (List.length lst_of_words) in
  List.nth lst_of_words index 


let astrisks_maker word=
  let lst = String.split_on_char ' ' word in
  let rec astrisks_helper lst1 =
    match lst1 with 
    | [] -> ""
    | h :: t -> (String.make (String.length h) '*') ^ " " ^ (astrisks_helper t)
  in astrisks_helper lst

let main_hangman ()=
  (* Graphics.open_graph ""; *)
  Gui.make_graph "" Graphics.red;
  let word = word_picker hangman_words in
  let astrisks = astrisks_maker word in
  main_hangman_helper [] word 10 astrisks;


