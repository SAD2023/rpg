let hangman_words = ["This game sucks"; "Cornell"; "Peace Love and OCaml";
                     "Goodbye OCaml Programmers"; "Stupid OCaml Syntax";
                     "Let me put this in utop"; "I'll let you think about it"; 
                     "This is 3110"; "Jump off a bridge"]

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

let rec main_hangman_helper letters_guessed word guesses_left acc=
  if guesses_left = 0 then print_string "You lose :-("
  else
    print_string ("\nGuesses left: " ^ string_of_int guesses_left ^
                  "\nGuesses so far: " ^ acc ^ "\n" ^
                  "Guess a letter or word: ");
  let guess = (read_line ()) in
  let empty = ref "" in
  if String.length guess = 1 then
    let chara = (String.get guess 0) in
    begin 
      if String.contains word chara then 
        let astrisks = (format chara word empty acc) in
        begin
          if String.contains astrisks '*' = false then
            begin
              print_string "Congratulations! You guessed the word correctly!"
            end
          else 
            print_string ("Wrong Character! You have " ^
                          (string_of_int guesses_left) ^ " guesses left \n");
          let astrisks = (format chara word empty acc) in
          print_string astrisks;
          main_hangman_helper (chara :: letters_guessed) word (guesses_left - 1) astrisks
        end
      else
        print_string ("Wrong Character! You have " ^
                      (string_of_int guesses_left) ^ " guesses left \n");
      let astrisks = (format chara word empty acc) in
      print_string astrisks;
      main_hangman_helper (chara :: letters_guessed) word (guesses_left - 1) astrisks
    end
  else if guess = word then 
    print_string "Congratulations! You guessed the word correctly!"
  else begin
    print_string "That is not the correct word. Try again";
    main_hangman_helper letters_guessed word (guesses_left - 1) acc
  end

(* let astrisks phrase acc =
   for i =0 to String.length phrase -1 do
    if String.get phrase i <> ' ' then 
   done;  *)

let main_hangman =
  main_hangman_helper [] "test" 10 "****";
  print_string "\n"

