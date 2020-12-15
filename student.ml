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

exception Poor of brbs


(** [initial name] initializes the student/player with initial values for each
    of their attributes and with [name] *)
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


(** [print_string_list] concatenates the elements of a string list, with a
    comma and a space in between each element *)
let rec print_string_list = function
  | [] -> ""
  | h :: t -> h ^ ", " ^ print_string_list t


(** [get_list_of_names] returns all of the names in a list of friends *)
let rec get_list_of_names = function
  | [] -> []
  | h :: t -> Friend.get_name h :: get_list_of_names t


(** [gui_print_characteristics student] returns a string of all of the
    attributes of [student] to be passed into a function that will print the 
    string in the GUI *)
let gui_print_characteristics student = 
  ("Name: " ^ student.name ^
   "~Age: " ^ string_of_int student.age ^
   "~Morality: " ^ string_of_float student.morality ^
   "~GPA: " ^ string_of_float student.gpa ^ 
   "~Social Life: " ^ string_of_float student.social_life ^
   "~Health: " ^ string_of_float student.health ^ 
   "~BRBs: " ^ string_of_float student.brbs ^ 
   "~Friends: " ^ print_string_list (get_list_of_names student.friends))


(**[bounds] checks to see if a value is between 0.0 and a given upper bound.
   If it is not, then it will return the upper or lower bound that it 
   exceeding *)
let bounds upper attribute =
  if attribute > upper then upper 
  else if attribute < 0.0 then 0.0 
  else attribute


(**[brb_bounds] checks to see if the student's current brbs is between 0.0 and 
   100.0. If it is not, then it will return the upper bound (100.0) that it 
   exceeding or raise [Poor attribute] if it does not meet the lower bound of 
   0.0 *)
let brb_bounds attribute = 
  if attribute > 100.0 then 100.0
  else if attribute < 0.0 then raise (Poor attribute)
  else attribute


(** [update_student student morality gpa social_life health brbs] takes in
    a student and creates a new student with the previous student's attributes
    added to the attributes given. *)
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


(** [update_friend_list_only student friends_list] returns a student identical
    to the previous student but with the friend list friends_list *)
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


(** [friend_list_getter student] returns all of the friends that a student has
    made. *)
let friend_list_getter student = 
  student.friends


(** [see_if_you_have_friend name student] checks to see if there exists a friend
    with [name] in the list of friends belonging to this [student], returning
    true if this friend exists in the list, and false otherwise *)
let see_if_you_have_friend name student = 
  let list_of_names = List.map Friend.get_name (friend_list_getter student) in 
  List.mem name list_of_names 


(** The following variables are all potential judgements that can print in the 
    GUI periodically throughout the game, dependent on the student's particular 
    attributes by that point in the game  *)
let get_str_bad_gpa student = ("ew your gpa is " ^ (string_of_float student.gpa) 
                               ^ " Move to info sci") 
let get_str_good_gpa student = ("wow your gpa is " ^ (string_of_float student.gpa)
                                ^  " Walker White would be proud!")
let low_morality_judge = "Heh. You're kind of a mean person. I have an internship for you at Goldman Sachs"
let high_morality_judge = "You're a decent human it seems. Boring"
let low_health_judge = "You're definitely a cs major. Please take a shower."
let high_health_judge = "You're a fine human specimen."
let low_brbs_judge student = "You're broke. Get a job. You only have " ^ 
                             (string_of_int (int_of_float student.brbs)) ^ 
                             " brbs left."
let high_brbs_judge student = "You're ballin! You have " ^
                              (string_of_int (int_of_float student.brbs)) ^ 
                              " brbs left."
let low_social_life_judge = "Get some friends loser"
let high_social_life_judge = ("Oh ma gosh you're so popular...")


(** [judgement student] takes in a student and prints out a string judging 
    their various attributes, depending on the actions that they have taken, 
    and if they are ethical or not *)
let judgement student = 
  Gui.make_graph ("AGE: " ^ string_of_int student.age) Graphics.red;
  Gui.make_graph_addon ~color:Graphics.yellow "Hmm... time to judge your character!";
  Gui.make_graph_addon ~color:Graphics.red "First, let's look at your gpa. ";
  if student.gpa <= 1.5 then Gui.make_graph_addon (get_string_gpa student)
  else Gui.make_graph_addon (get_str_good_gpa student);

  Gui.make_graph_addon ~color:Graphics.red "Let's see how scummy you are.";
  if student.morality <= 30.0 then Gui.make_graph_addon low_morality_judge 
  else Gui.make_graph_addon high_morality_judge;

  Gui.make_graph_addon ~color:Graphics.red "How's that gym membership going?";
  if student.health <= 50.0 then Gui.make_graph_addon low_health_judge
  else Gui.make_graph_addon high_health_judge;

  Gui.make_graph_addon ~color:Graphics.red "Let's see how rich your dad is.";
  if student.brbs <= 50.0 then Gui.make_graph_addon (low_brbs_judge student)
  else Gui.make_graph_addon (high_brbs_judge student);

  Gui.make_graph_addon ~color:Graphics.red "Got any friends?";
  if student.social_life <= 40.0 then Gui.make_graph_addon low_social_life_judge
  else Gui.make_graph_addon high_social_life_judge
(* ;

   List.iter 
   (fun x -> 
     Gui.make_graph_addon (Friend.get_name x ^ " " ^ string_of_int 
                            (Friend.get_closeness x) ^ "")) student.friends *)


(** The following variables are all potential endings that can print in the GUI
    at the end of the game, dependent on the student's particular attributes by 
    the end of the game  *)
let final_judgement_intro = "Congratulations! Your time at Cornell has come to an end. \
     ~Now it's time to go out into the real world."
let goldman_sachs_ending = "You were a terrible human being throughout your college life, but not \
     ~a terrible student. Seems like you left your morals somewhere along the \
     ~lines. This is the perfect combination to become successful! \
     ~You have been invited to intern at Goldman Sachs. \
     ~Good luck ripping people off."
let google_ending = "It seems like you have a 4.0 in all of your CS classes. \
     ~You are also very lonely.\
     ~Congrats on your Google internship!"
let impossible_ending = "Congratulations!! You made it all the way through college with an \
     ~incredibly high GPA and lots of friends and connections, all without \
     ~sacrificing your health or your soul! How did you do it? Are you a \
     ~wizard? Why didn't you go to Hogwarts then?\
     ~~You received offers from Google and Facebook, but you turn them down to\
     ~work at a small non-profit saving kittens and ending world hunger. I \
     ~heard that they're considering you for a Nobel Prize. Woo. Excuse me \
     ~while I go cry with the remaining 2 shards of my dignity."
let extra_semester_ending = "You failed to meet the academic requirements and will have to stay an \
     ~extra semester. Congrats Van Wilder!\

     ~Hint: there's this thing called an academic advisor!"
let data_scientist_ending = "You barely made it, but hey! You can now work as a 'Data Scientist' at \
     ~your dad's company (it involves the art of inputting numbers into excel \
     ~and convincing an entire company to pay you for it)."
let english_teacher_ending = "You changed your major from CS to communications. You are now a middle \
     ~school English teacher in a room full of screaming children. Enjoy your \
     ~liberal arts degree!"
let pollack_butler_ending = "Wow. You have no more money left. You got an offer at a start up, but it \
     ~doesn't pay very well, so you take the only offer you could get: \
     ~Martha Pollack's personal butler."
let grad_school_ending = "You're not ready for real life yet. You'll now go to \
     ~grad school!"
let medicine_ending = "Even though you were a CS major, it looks like you're truly passionate about \
     ~medicine. You decide to take a few gap years to build up your profile before \
     ~applying to medical school."
let cs_around_world = "Hey it looks like you're graduating pretty popular! You've mastered the \
     ~fine art of networking and you take this key skill with you as you integrate your CS
     ~knowledge into the business world. Safe travels!"




(** [final_judgement student] takes in a student and prints out a string 
    judging their various final attributes, depending on the actions that they 
    have taken, and if they are ethical or not. It also determines their future 
    career. *)
let final_judgement student =
  Gui.make_graph (gui_print_characteristics student) Graphics.red;
  Gui.make_final_judgement_graph_addon final_judgement_intro;
  (if student.gpa > 3.7 && student.morality < 30.0 
   then Gui.make_final_judgement_graph_addon goldman_sachs_ending
   else if student.gpa > 3.9 && student.social_life < 30.0 
   then Gui.make_final_judgement_graph_addon google_ending
   else if student.gpa > 3.99 && student.social_life > 95.0 && 
           student.morality > 90.0 && student.health > 90.0 
   then Gui.make_final_judgement_graph_addon impossible_ending
   else if student.gpa > 3.8 && student.social_life < 60.0 && 
           student.morality > 60.0 && student.health > 70.0 
   then Gui.make_final_judgement_graph_addon medicine_ending
   else if student.social_life > 90 && student.gpa > 3.0
   then Gui.make_final_judgement_graph_addon cs_around_world
   else if student.gpa < 1.0 
   then Gui.make_final_judgement_graph_addon extra_semester_ending
   else if student.gpa < 2.0 && student.brbs > 60.0 
   then Gui.make_final_judgement_graph_addon data_scientist_ending
   else if student.gpa < 3.0 && student.social_life > 4.0 
   then Gui.make_final_judgement_graph_addon english_teacher_ending
   else if student.brbs = 0.0 && student.gpa < 3.0 
   then Gui.make_final_judgement_graph_addon pollack_butler_ending
   else  Gui.make_final_judgement_graph_addon grad_school_ending);

  Gui.make_final_judgement_graph_addon "Press \"q\" to quit.";
  if Graphics.read_key ()='q' then Graphics.close_graph () else ()


(** [return_decisions student] returns all of the decisions that a student has
    made. *)
let return_decisions student = 
  student.decision_list


(** check_decisions decision student returns true if the given decision is one
    that the student has made, and false if not *)
let check_decisions decision student = 
  List.mem decision student.decision_list


(** [give_money student] returns a new student with the same qualities but with
    three more BRBs than the old student. For use in unscrambler minigame in
    "minigames.ml" *)
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


(** [update_age student] returns  new student with the same qualities but one 
    year older than the old student. *)
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