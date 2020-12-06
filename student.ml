open Friend
open Graphics

type age = int

type name = string

type morality = float

type gpa = float

type social_life = float

type health = float

type brbs = float

type decision = string

type student = {
  name: name;
  age: age;
  morality: morality;
  gpa: gpa;
  social_life: social_life;
  health: health;
  brbs: brbs;
  friends: Friend.friend list;
  decision_list: decision list;
}

let initial name = 
  {
    name = name;
    age = 18;
    morality = 0.0;
    gpa = 0.0;
    social_life= 0.0;
    health = 0.0;
    brbs= 50.0;
    friends= [];
    decision_list = [];
  }

(** [make_student] creates a new student with the given parameters *)
let make_student name age morality gpa social_life health brbs friends decision=
  {
    name = name;
    age = age;
    morality = morality;
    gpa = gpa;
    social_life =social_life;
    health = health;
    brbs = brbs;
    friends = friends;
    decision_list = decision;
  }

(** [print_string_list] prints out the elements of a string list. with a
    comma and a space in between each element *)
let rec print_string_list = function
  | [] -> ""
  | h :: t -> h ^ ", " ^ print_string_list t

(** [get_list_of_names] returns all of the names in a list of friends *)
let rec get_list_of_names = function
  | [] -> []
  | h :: t -> Friend.get_name h :: get_list_of_names t

let print_characteristics student = 
  print_string ("Name: " ^ student.name ^ "\n");
  print_string ("Age: " ^ string_of_int student.age ^ "\n");
  print_string ("Morality: " ^ string_of_float student.morality ^ "\n");
  print_string ("GPA: " ^ string_of_float student.gpa ^ "\n");
  print_string ("Social Life: " ^ string_of_float student.social_life ^ "\n");
  print_string ("Health: " ^ string_of_float student.health ^ "\n");
  print_string ("BRBs: " ^ string_of_float student.brbs ^ "\n");
  print_string ("Friends: " 
                ^ print_string_list (get_list_of_names student.friends))

(**[bounds] checks to see if a value is between 0.0 and a given upper bound.
   If it is not, then it will return the upper or lower bound that it 
   exceeding *)
let bounds upper attribute =
  if attribute > upper then upper 
  else if attribute < 0.0 then 0.0 
  else attribute

exception Poor of float

let brb_bounds attribute = 
  if attribute > 100.0 then 100.0
  else if attribute < 0.0 then raise (Poor attribute)
  else attribute

let update_student 
    student morality gpa social_life health brbs friends_list decision= 
  {
    name = student.name;
    age = student.age;
    morality = bounds 100.0 (student.morality +. morality);
    gpa = bounds 4.0 (student.gpa +. gpa);
    social_life = bounds 100.0 (student.social_life +. social_life);
    health = bounds 100.0 (student.health +. health);
    brbs = brb_bounds (student.brbs +. brbs);
    friends = friends_list;
    decision_list = decision :: student.decision_list;
  }

let update_friend_list_only student friends_list = 
  {
    name = student.name;
    age = student.age;
    morality = student.morality;
    gpa = student.gpa ;
    social_life = student.social_life;
    health = student.health;
    brbs = student.brbs;
    friends = friends_list;
    decision_list = student.decision_list;
  }

let friend_list_getter student = 
  student.friends


let see_if_you_have_friend name student = 
  let list_of_names = List.map Friend.get_name (friend_list_getter student) in 
  List.mem name list_of_names 

let judgement student = 
  Gui.make_graph ("AGE: " ^ string_of_int student.age) Graphics.red;
  Gui.make_graph_addon ~color:Graphics.yellow "Hmm... time to judge your character!";
  Gui.make_graph_addon ~color:Graphics.red "First, let's look at your gpa. ";
  if student.gpa <= 1.5 then Gui.make_graph_addon 
      ("ew your gpa is " ^ (string_of_float student.gpa) 
       ^ " Move to info sci") 
  else Gui.make_graph_addon ("wow your gpa is " ^ (string_of_float student.gpa)
                             ^  " Walker White would be proud!");

  Gui.make_graph_addon ~color:Graphics.red "Let's see how scummy you are.";
  if student.morality <= 30.0 then Gui.make_graph_addon 
      "Heh. You're kind of a mean person. I have an internship for you at Goldman Sachs" 
  else Gui.make_graph_addon "You're a decent human it seems. Boring";

  Gui.make_graph_addon ~color:Graphics.red "How's that gym membership going?";
  if student.health <= 50.0 then Gui.make_graph_addon 
      "You're definitely a cs major. Please take a shower." 
  else Gui.make_graph_addon "You're a fine human specimen.";


  Gui.make_graph_addon ~color:Graphics.red "Let's see how rich your dad is.";
  if student.brbs <= 50.0 then Gui.make_graph_addon (
      "You're broke. Get a job. You only have " ^ 
      (string_of_int (int_of_float student.brbs)) ^ " brbs left.")
  else Gui.make_graph_addon ("You're ballin! You have " ^
                             (string_of_int (int_of_float student.brbs)) ^ 
                             " brbs left.");


  Gui.make_graph_addon ~color:Graphics.red "Got any friends?";
  if student.social_life <= 40.0 then Gui.make_graph_addon 
      "Get some friends loser"
  else Gui.make_graph_addon ("Oh ma gosh you're so popular...")
(* ;

   List.iter 
   (fun x -> 
     Gui.make_graph_addon(Friend.get_name x ^ " " ^ string_of_int 
                            (Friend.get_closeness x) ^ "")) student.friends *)





let final_judgement student =
  print_string "\n";
  print_characteristics student;
  print_string "\n\nCongratulations! Your time at Cornell has come to an end. 
  Now it's time to go out into the real world. \n";
  if student.gpa > 3.7 && student.morality < 30.0 then print_string 
      "\nYou were a terrible human being throughout your college life, but not
       a terrible student. Seems like you left your morals somewhere along the 
       lines. This is the perfect combination to become successful! 
       You have been invited to intern at Goldman Sachs. \n
  Good luck ripping people off. \n" 

  else if student.gpa > 3.9 && student.social_life < 30.0 
  then print_string 
      "You smell terrible and you have a 4.0 in all of your CS classes. 
      You are also very lonely. \n
  Congrats on your Google internship! \n"

  else if student.gpa < 3.0 && student.social_life > 4.0 then print_string
      "You changed your major from CS to communications. You are now a middle
       school English teacher in a room full of screaming children. Enjoy your
        liberal arts degree! \n"

  else print_string "\nYou're not ready for real life yet. You'll now go to 
  grad school! \n\n"


let return_decisions student = 
  student.decision_list

let check_decisions decision student = 
  List.mem decision student.decision_list

let give_money student = 
  {
    name = student.name;
    age = student.age;
    morality = student.morality;
    gpa = student.gpa;
    social_life = student.social_life;
    health = student.health;
    brbs = student.brbs +. 3.0;
    friends = student.friends;
    decision_list = student.decision_list;
  }

let update_age student= 
  {
    name = student.name;
    age = student.age + 1;
    morality = student.morality;
    gpa = student.gpa;
    social_life = student.social_life;
    health = student.health;
    brbs = student.brbs +. 3.0;
    friends = student.friends;
    decision_list = student.decision_list;
  }