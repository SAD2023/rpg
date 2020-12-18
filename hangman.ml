(* open Gui *)
open Graphics

(** A list of words to guess *)
let hangman_words = ["this game sucks"; "cornell"; "peace love and ocaml";
                     "goodbye ocaml programmers"; "stupid ocaml syntax";
                     "let me put this in utop"; "ill let you think about it"; 
                     "this is 3110"; "send me a screenshot"; "DON'T CROP"]

(** [make_list_of_strings phrase] makes a list with each element a different
    word in the list*)
let make_list_of_strings phrase = 
  String.split_on_char ' ' phrase

(** [format char phrase acc so_far] takes a word and that word with a number of
    characters replaced by astrisks. For a given character, if it is a member of
    the word, then every instance will be replaced by astrisks *)
let format char phrase acc so_far=    
  for i =0 to String.length phrase -1 do
    if String.get phrase i = char then acc.contents <- 
        acc.contents ^ (String.make 1 char) 
    else
    if String.get so_far i <> '*' then acc.contents <- 
        acc.contents ^ (String.make 1 (String.get so_far i)) 
    else
      acc.contents <- acc.contents ^ "*"
  done; 
  let value = acc.contents in
  acc.contents <- "";
  value

(** [string_of_char_list lst] returns a string of characters in a character
    list separated by commas *)
let rec string_of_char_list lst  =
  match lst with
  | [] -> ""
  | h :: t -> (String.make 1 h) ^ ", " ^ string_of_char_list t 
(** [initial_screen letters_guessed word guesses_left acc] simply adds on an
    initial screen that prints out the player's initial statistics *)
let initial_screen letters_guessed word guesses_left acc =
  Gui.make_final_judgement_graph_addon ~color:Graphics.red "Guesses left: ";
  Gui.make_graph_addon_no_newline (string_of_int guesses_left);
  Gui.make_final_judgement_graph_addon ~color:Graphics.red "Guesses so far: ";
  Gui.make_graph_addon_no_newline acc;
  Gui.make_final_judgement_graph_addon ~color:Graphics.red 
    "Letters guessed so far: ";
  Gui.make_graph_addon_no_newline (string_of_char_list 
                                     (List.sort_uniq 
                                        compare letters_guessed));
  Gui.make_final_judgement_graph_addon ~color:Graphics.red
    "Guess a letter or word and then press '.': "

(**[correct_guesses_left_string guesses_left] is a string that simply states
   that the player guessed the correct letter, and however many guesses left 
   they have*)
let correct_guesses_left_string guesses_left =
  "Correct letter!"

(**[wrong_guesses_left_string guesses_left] is a string that simply states
   that the player guessed the incorrect letter, and however many guesses left 
   they  have*)
let wrong_guesses_left_string guesses_left =
  "Wrong letter! You have " ^ (string_of_int (guesses_left-1)) ^ " guesses left"

(** [congrats] is a string that should be displayed when the word is guessed
    correctly in hangman *)
let congrats = "Congratulations! You guessed the word correctly!"


(** [main_hangman_helper letters_guessed word guesses_left acc] recursively asks
    the player for input, and then checks if their guess is correct. If not,
    it will run the engine through again until either it is correct, or they
    runs out of turns. *)
let rec main_hangman_helper letters_guessed word guesses_left acc=
  if guesses_left = 0 then 
    Gui.make_graph_addon ("You lose :-(, the correct word was: " ^ word) else
    (Gui.make_graph "Let's play hangman! Can you guess the word?" 
       Graphics.yellow;
     initial_screen letters_guessed word guesses_left acc);
  let guess = (Gui.type_out_string Graphics.yellow) in let empty = ref "" in
  if String.length guess = 1 then let chara = (String.get guess 0) in
    begin if List.mem chara letters_guessed then
        (already_guessed_word letters_guessed word guesses_left acc chara empty)
      else if String.contains word chara then 
        let astrisks = (format chara word empty acc) in 
        (if String.contains astrisks '*' = false then 
           (Gui.make_graph_addon  ~color:Graphics.green congrats; Unix.sleep 1)  
         else 
           (correct_letter letters_guessed word guesses_left acc chara empty))
      else (wrong_letter letters_guessed word guesses_left acc chara empty)
    end else if guess = word then 
    (Gui.make_graph_addon  ~color:Graphics.green congrats; Unix.sleep 1)
  else (wrong_word letters_guessed word guesses_left acc)


(** [already_guessed_word letters_guessed word guesses_left acc ] if the player
    has already guessed the letter, then this whould follow:
    "You have already guessed this letter. Try again!" will be printed out, and
    the function will be called again.*)
and already_guessed_word letters_guessed word guesses_left acc chara empty=
  let astrisks = (format chara word empty acc) in
  Gui.make_graph_addon  ~color:Graphics.yellow
    "You have already guessed this letter. Try again!";
  Unix.sleep 1;
  main_hangman_helper (letters_guessed) word (guesses_left) astrisks

(** [correct_letter_guess letters_guessed word guesses_left acc chara empty]
    if the player guesses a correct letter, then the GUI will print out that
    they did indeed guess it correctly, and then prompt them to guess another
    character or word *)
and correct_letter letters_guessed word guesses_left acc chara empty=
  Gui.make_graph_addon  ~color:Graphics.green
    (correct_guesses_left_string guesses_left);
  let astrisks = (format chara word empty acc) in
  Unix.sleep 1;
  main_hangman_helper (chara :: letters_guessed) word (guesses_left) astrisks

(** [wrong_letter letters_guessed word guesses_left acc chara empty]
    if the player guesses an incorrect letter, then the GUI will print out that
    they did indeed guess it incorrectly, and then prompt them to guess another
    character or word *)
and wrong_letter letters_guessed word guesses_left acc chara empty=
  Gui.make_graph_addon  ~color:Graphics.red
    (wrong_guesses_left_string guesses_left);
  let astrisks = (format chara word empty acc) in
  Unix.sleep 1;
  main_hangman_helper (chara :: letters_guessed) word (guesses_left -1) astrisks

(** [wrong_words letters_guessed word guesses_left acc chara empty]
    if the player guesses an incorrect letter, then the GUI will print out that
    they did indeed guess it incorrectly, and then prompt them to guess another
    character or word *)
and wrong_word letters_guessed word guesses_left acc =
  Gui.make_graph_addon  ~color:Graphics.red
    "That is not the correct word. Try again"; 
  Unix.sleep 1;
  main_hangman_helper letters_guessed word (guesses_left - 1) acc 


(** [word_picker lst_of_words] picks a random word in a list of words *)
let word_picker lst_of_words = 
  let index  = Random.int (List.length lst_of_words) in
  List.nth lst_of_words index 

(** [astrisks_maker word] returns a string with every character in a string 
    replaced by '*' except for spaces which are left as is. *)
let astrisks_maker word=
  let lst = String.split_on_char ' ' word in
  let rec astrisks_helper lst1 =
    match lst1 with 
    | [] -> ""
    | h :: t -> (String.make (String.length h) '*') ^ " " ^ (astrisks_helper t)
  in astrisks_helper lst

(** [main_hangman ()] is the main engine for the hangman minigame. The player 
    has 10 lives and each time they guess a character or word incorrectly,
     they lose a turn. The player is allowed to guess either a character or 
     word at each turn.
*)
let main_hangman ()=
  Graphics.open_graph "";
  Gui.make_graph "" Graphics.red;
  let word = word_picker hangman_words in
  let astrisks = astrisks_maker word in
  main_hangman_helper [] word 10 astrisks;

