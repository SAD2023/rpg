open Random
open Gui

type name = string

type rules = string

type correct_answer

type win = bool

type minigame

open Stdlib

(** [remove_char str index] takes in a string and index value and removes
    a character in order to switch up the ordering of a word. *)
let remove_char str index =
  let sub2_start = String.sub str (index + 1) in
  let sub2_length = String.length(str) - (index + 1) in 
  String.sub str 0 index ^ sub2_start sub2_length

(** [scramble_word] takes in a string word and scrambles the given word
    with the remove_char helper function. *)
let rec scramble_word (word : string) (result : string)=
  if String.length word = 0 then result else
    let index = (Random.int (String.length word)) in
    scramble_word (remove_char word index) (result ^ (String.make 1 
                                                        (String.get word 
                                                           index)))

let scramble_intro word = 
  Gui.make_graph ("Time to test your intellect! Can you unscramble this word? \
  ~Make sure to press '.' when you're done! \
  ~ \
  ~Your word: " ^  (scramble_word word "") ^ "~ \
  ~") Graphics.red

let rec scramble_engine word input = 
  if String.uppercase_ascii input = String.uppercase_ascii word then "Correct!" 
  else "Wrong!"

