let hangman_words = ["This game sucks"; "Cornell"; "Peace Love and OCaml";
                     "Goodbye OCaml Programmers"; "Stupid OCaml Syntax";
                     "Let me put this in utop"; "I'll let you think about it"; 
                     "This is 3110"; "Jump off a bridge"]

let make_list_of_strings phrase = 
  String.split_on_char ' ' phrase

let format char phrase acc=    
  for i =0 to String.length phrase -1 do
    if String.get phrase i = char then acc.contents <-(String.make 1 char) else
      acc.contents <- acc.contents ^ "*"
  done; 
  acc.contents




