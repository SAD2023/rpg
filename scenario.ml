open Storage 
open Friend

let jack = make_friend "Jack" 5 0
let nicola = make_friend "Nicola" 5 0
let gandhi = make_friend "Gandhi" 5 0
let maximillian = make_friend "Maximillian the III" 5 0
let lirinda = make_friend "Lirinda" 5 0 
let sam = make_friend "Sam" 5 0
let brad = make_friend "Brad" 5 0
let potential_friend_list = [jack; nicola; gandhi; maximillian; lirinda; sam; brad]  

exception Unimplemented 
type prompt = string
type choice = string
type hidden_choice = choice
type choices = choice list
type hidden_choices = hidden_choice list
exception InvalidInput of choice

type scenario = {
  name: string;
  prompt: prompt;
  choices: choice list;
  hidden_choices : hidden_choice list;
}
(** [get_element_out_of_list] exerts the head of a list; if the list 
    is empty, an exception is raised. *)
let get_element_out_of_list list = 
  match list with 
  | [] -> raise (InvalidInput "Wrong input")
  | h :: t -> h

(**[tuple_friend_helper] is a helper function thatt extracts the first value of
   the tuple of (decision, friend name) to make a list of decision*)
let rec tuple_friend_helper tuple_list acc = 
  match tuple_list with 
  | [] -> acc
  | h :: t -> tuple_friend_helper t (fst h :: acc) 

(**Takes a decision and returns the string of the name of a friend or "NONE" *)
let match_decision_to_friend (decision:string) =
  let decision_list = tuple_friend_helper Storage.scenario_friends_list [] in 
  let is_this_a_friend_decision = List.mem decision decision_list in 
  if is_this_a_friend_decision then 
    let list_of_one_friend = List.filter (fun x -> fst x  = decision) Storage.scenario_friends_list in 
    snd (get_element_out_of_list list_of_one_friend)
  else "NONE"

(**takes a string of the name of a friend and returns a list with one friend instance *)
let give_friend name_of_friend = 
  try 
    let friend_in_list = List.filter (fun x -> (Friend.get_name x) = name_of_friend) potential_friend_list in  
    friend_in_list
  with InvalidInput "Wrong input" -> 
    []

(**takes a decision string and returns a list with one friend instance *)
let main_friend_function decision = 
  let name_of_friend = match_decision_to_friend decision in 
  let friend_list = give_friend name_of_friend in 
  friend_list

(** [match_input_to_input] matches a user's input; if it matches a valid
    decision pertaining to the given scenario, then it is a valid input but 
    if it isn't valid, it raises an exception. *)
let rec match_input_to_choice choices input =
  match choices with 
  | [] -> raise (InvalidInput input)
  | h :: t -> if h = input then h else match_input_to_choice t input


let starting_scenario = {
  name = "fresh start";
  prompt = "You are about to move into the low rises. Make sure you're ready 
  for a riot. Stay strapped at all times. Do you want a single or double?";
  choices = ["double"; "single"];
  hidden_choices = ["Triple"; "Live with happy dave"];
}

type next_scenarios = scenario list

(** [print_choices] prints the choices pertaining to a given scenario to 
    the terminal. *)
let rec print_choices choices =
  match choices with 
  | [] -> ""
  | h :: t -> "\n -" ^ h ^ (print_choices t) 


let return_choices scenario = 
  scenario.choices

(** [print_prompt] prints the prompt pertaining to a given scenario to 
    the terminal. *)
let print_prompt scenario = 
  ANSITerminal.(print_string [blue] (scenario.prompt ^ "\n")); 
  ANSITerminal.(print_string [yellow] (print_choices scenario.choices ^ "\n"))

(**[filter_helper] is a helper function to filter. *)
let filter_helper a b = 
  String.uppercase_ascii a = String.uppercase_ascii (fst b)



(** [make_scenario] takes in types name, prompt, choices, and hidden_choices
    and produces a new scenario type. *)
let make_scenario name prompt choices hidden_choices =
  {
    name = name;
    prompt = prompt;
    choices = choices;
    hidden_choices = hidden_choices;
  }


let meet_brad =  make_scenario "Meet Brad" "You're doing laundry for the first time 
and  you start talking to Brad, who lives  down the hall. He asks if you want 
to go to an O-Week event with him and some friends. What do you want to do?" 
    ["O Week"; "Stay in"; "Look at textbook"] []

let roommate_and_brad = 
  make_scenario "Roommate and Brad" "Your roommate comes with you, but 
  unfortunately needs a little help going home..." 
    ["Help them home"; "Leave without them"] []

let no_roommate_and_brad = 
  make_scenario "No Roommate and Brad" "You see someone (Aquinas) and they 
   seem very lost. Do you help them or stay with Brad and see if they can find 
   their way by themselves?" ["Help them home"; "Leave without them"] []


let first_day = make_scenario "First Day" "It's the first day of classes! 
Your alarm buzzes  WAAAY too early. Do you snooze or go to your first class?" 
    ["Snooze"; "Go to class"] []

let clubfest = 
  make_scenario "Clubfest" "It's Clubfest! Choose a club and decide whether 
    or not you actually show up to the first meeting here:" 
    ["Fun Club"; "Career Club"; "Charity Club"] []

let halloween = make_scenario "Halloween" "It's Halloween! You want to go 
trick-or-treating, but you have a prelim the next morning. Do you…" 
    ["Go Trick or Treating"; "Study"] []

let club_meeting = make_scenario "Club Meeting" "Your club has a meeting! 
However, your friend invited you to go hiking. What do you do?" 
    ["Go to club meeting"; "Go hiking"] []

let study_partner = make_scenario "study partner" "You start studying but the 
material is really hard! Do you want to sign up for the study partner program and 
find someone else to study with?" ["Sign up"; "Nah I'm good"] []

let stir_fry = make_scenario "stir fry" "You go to Okenshields to see Happy Dave's 
beautiful face, but you notice an ECE major coughing into the stir fry. Perhaps you 
should investigate this grave injustice to the Cornell community. "
    ["Do the right thing"; "Fuck Okies"] []

let investigation = make_scenario "investigation" "You find a man in a bear costume trying 
to find a table at Okies (an impossible task, as you are aware. Do what you must " 
    ["Unmask the bear man"; "Make a reddit post about it"] []

let club_social = make_scenario "social event" "A club you signed up for is hosting a 
social event for new members! " ["Attend the social"; "Binge watch youtube"; "do some pushups"] []

let drop = make_scenario "drop" "The deadline to drop a class is
almost here! " ["Lower the course load"; "Keep current course load"] []

let dinner = make_scenario "dinner out" "Your friends want to go to Antlers for dinner on Friday.
They ask whether you want to join them " ["Go to dinner"; "Stay home and be lonely"] []

let office_hours = make_scenario "office hours" "Your professor gave you an assignment
and didn't teach several concepts needed to solve it. Maybe you should go to office hours 
to figure it out (note: it will be crowded like a fish market, you will be #135 on the queue,
and will likely have a mental breakdown" ["Sacrifice mental health for gpa"; "Fail the assignment"] []

let frisbee = make_scenario "frisbee team" "One of your friends is in the frisbee
team and invites you to join. It might be some good exercise" ["Join the frisbee team"; "Don't join"] []

let snitch = make_scenario "snitching" "You see a beer can in one of your 
suitemate's wastebasket. What should you do?" ["Ignore it. It's college"; "Report it to the RA"] []

let transport =  make_scenario "transport" "It's starting to snow and it's not much harder 
to walk. You've been late to lectures a couple of times already. It might be smart to get a bike"
    ["Get a bike"; "Keep walking"; "Start using the bus pass"] []

let touchdown = make_scenario "Touchdown" "On your way to class, you run into touchdown, Cornell's Big Red 
Mascot! But it seems you're running late." ["Stop and take a pic with touchdown"; "Rush to class"] []

let nasties_run  = make_scenario "Nasties Run" 
    "Your roommate wants to cook dinner tonight to bond together, but you're really craving some ~unhealthy~ food from nasties." 
    ["Cook with roommate"; "Onion rings and chicken tenders from Nasties"] []

let igloo = make_scenario "Igloo" "It seems like some of your floormates are heading out to make use of the huge 
snowstorm and build an igloo in the CKB quad. Staring at your study sheet for a prelim that's in a few days, you 
wonder what you should do." ["Build an igloo"; "Study for prelim"; "Netflix and hot chocolate"] []

let winter_sign  = make_scenario "Winter Sign" "On your way back to north, you notice a ‘no winter maintenance'
sign in front of you. You know it's a tradition to ‘borrow' one of these at least once while at Cornell." 
    ["Take the sign"; "Leave it"] []

let winter_sign_fall = make_scenario "Winter Sign Fall" "As soon as you get the sign off the ground, you fall into 
a slippery, icy patch right next to it. Recognizing the irony of what just happened, you wonder if you should put the
sign back so others can avoid injury" ["Put the sign back"; "Keep going"] []

let wsh = make_scenario "WSH" "Surprisingly, this is the first time you've set foot in Willard Straight Hall. Why are
you here" ["Visit Denice Cassaro"; "Okenshield's"; "Watch a movie" ] ["Popcorn"]

let post_finals = make_scenario "Post Finals" "You finished your finals early, and some of your friends are staying
a few days after to hang out stress-free. But your family called the other day mentioning how much they miss you, 
and you realize you miss them alot too" ["Go back home"; "Stay in Ithaca"] []

let rush = make_scenario "Rush" "Welcome to a new semester! You are now able to participate in frat sorority 
recruitment. Would you like to rush?" ["Rush"; "Don't rush"] [] 

let rush_2 = make_scenario "Rush pt 2" "YAYYYY, you've gotten a bid!! Do you wish 
to take it?" ["Take the bid"; "Don't take the bid"] []

let snow_slide = make_scenario "Snow slide" "Let Ithaca snow, let Ithaca snow!!! A snowstorm hits Ithaca which means Martha
has cancelled classes but more importantly, the slope is covered in a nice coat of snow. How do you spend your day of no 
classes? How about you grab a sled and head down the slope!" ["Slide down the slope"; "Snuggle up with friends"; "Watch lectures"] []

let seasonal_depression = make_scenario "Seasonal depression" "You're going through the semester and at a time of prime Ithaca
winter weather, you start to catch seasonal depression and the semester seems to drag. How do you combat
it?" ["Talk to a caps counselor"; "binge on junk food and Netflix shows"; "hang out with friends"] []

let internship = make_scenario "Internship" "As you go through the semester, you realize that it would be a great time to 
start looking into internships for the summer break. However, you've never done this before and need help on your resume
." ["Go to the career center"; "Just apply next year"] []

let spring_break = make_scenario "Spring break" "Your first college spring break! Time to go crazy and destress from a 
long and painful semester of classes. How do you plan on spending it?" ["Stay on campus"; "Go home"; "Vacation with friends"] []

let slope_day = make_scenario "Slope day" "Time to celebrate the end of classes and there's no better way than to celebrate
at slope day!!! How shall you commemorate the end of the school year?" ["go to the slope"; "start studying early"; "sleep"] []

let slope_day_2 = make_scenario "Slope day pt 2" "You got your wristband and decided to head down the slope with some friends.
There are some people checking bags at the top of the slope. What are you guys going to do?" ["Sneak it in"; "Don't sneak it in"] []

let finals = make_scenario "Ew finals" "It's that time of the year where students pull all nighters and drown gallons of coffee 
and red bull. There's a brief study period before the start of your finals. How do you wish to spend all of that 
time?" ["Study most of the time"; "Mix of friends and books"; "Don't study at all"] []

let olin_finals = make_scenario "Olin finals" "You decide that the best environment to study for finals is at Olin library. However,
you go inside and discover that the stacks as well as every other room in Olin is packed to the brim with busying students. 
What do you do now?" ["Wait around for a seat"; "Study somewhere else"] []

let classes = make_scenario "Classes" "It's time to pick out your classes! But oh no! You really want to take the Ice Cream 
class with your friend, but  it conflicts with CS 3110, which you need for your major!" ["Ice Cream Class"; "CS 3110"] []

let major = make_scenario "Major" "Your advisor asks if you want to commit to your major right away,
or wait until the end of the year." ["Commit"; "Later"] []

let gym_pass = make_scenario "Gym Pass" "You know that you have a busy semester coming up, but you also think that
this is the year that you'll get a 7 pack of abs. Should you get a gym pass?" ["Get a gym pass"; "No never going to use it"] []

let friday_afternoon = make_scenario "Friday Afternoon" "Wow! You actually have a bit of free time this afternoon! 
You have plans with friends later, but what should you do with your extra free hours.
" ["Start your homework"; "Watch the Office"; "Go to the gym"; "Do laundry"] []

let career_fair_choice = make_scenario "Career Fair Choice" "The Virtual Career 
Fair is in a couple of days. However, you also have a prelim coming up. You know 
that you still have to fix up your resume and research the companies in 
attendance, all of which will take away time from studying. Do you want to go 
to the career fair?" ["Not career fair"; "Career fair"] []

let career_fair = make_scenario "Career Fair" "You talk to several companies. 
Which one do you want to apply for a Summer Internship?"
    ["Big tech company"; "Small start up"; "Non profit"] []

let academic_integrity = make_scenario "Academic Integrity" 
    "Your friend left their homework off to the last minute and ask if they can 
see yours to check their work. Do you let them?" ["Help them"; "I would never"] 
    []

let applications = make_scenario "Applications" "You are really scared that you 
will be unable to get a summer internship. You have some free time this weekend. 
Do you want to apply for some internships, spend time with friends, or 
do homework?" ["Apply to internships"; "Spend time with friends"; "Work on homework" ] []

let football_game = make_scenario "Football Game" "Cornell is playing Dartmouth 
to go, but you have a CS project due in a couple of days" 
    ["Football game"; "CS Project"] []

let canada_goose = make_scenario "Canada Goose" "It's starting to get really 
cold out! You need to get a new winter jacket. Which should you buy?" 
    ["Canada Goose Jacket"; "Jacket from TJ Maxx"] ["Freeze"]


(** List of all the scenarios *)
let scenario_list = [meet_brad; roommate_and_brad; no_roommate_and_brad;
                     first_day; clubfest; halloween; club_meeting; study_partner; 
                     stir_fry; investigation; club_social; drop; dinner; office_hours;
                     frisbee; snitch; transport; touchdown; nasties_run;
                     igloo; winter_sign; winter_sign_fall; wsh; post_finals;
                     finals; rush; rush_2; snow_slide; seasonal_depression; 
                     internship; spring_break; slope_day; slope_day_2; 
                     olin_finals; classes; major; gym_pass; friday_afternoon; 
                     career_fair_choice; career_fair; academic_integrity; 
                     applications; football_game; canada_goose]

(** [next_scenario decision] takes in a Student.decision and then prints out
    the next scenario that corresponds to it *)
let next_scenario decision choices = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_scenario_name in
    let scenario_name = snd (get_element_out_of_list tuple_list) in
    let one_scenario_list = List.filter (fun x -> String.uppercase_ascii x.name = String.uppercase_ascii scenario_name)
        scenario_list in 
    let next_scenario_element = get_element_out_of_list one_scenario_list in 
    next_scenario_element 
  else raise (InvalidInput decision)

(**Takes a decision and returns a list of consequences in the form [("gpa", 0.2)] *)
let return_consequences decision choices = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_consequence_list in 
    let consequence_list =  snd (get_element_out_of_list tuple_list) in
    if fst (get_element_out_of_list consequence_list) = "end" then  
      (ANSITerminal.(print_string [magenta] "Your time at Cornell has come to an end. Goodbye! \n");
       exit 0) else  
      consequence_list
  else raise (InvalidInput decision)

(**[tuple_helper] is a helper function that extracts the second value of
   the tuple of (attribute, change in attribute) to determine by how much to
   change an atrribute(s) when updating the student. *)
let rec tuple_helper attribute tuple_list = 
  match tuple_list with 
  | [] -> 0.0
  | h :: t -> if fst h = attribute then snd h else tuple_helper attribute t 

(**Takes a student and a list of consequences in the form [("gpa", 0.2)] and 
   creates a new student instance. *)
let match_consequences student consequence_list decision = 
  let gpa = tuple_helper "gpa" consequence_list in 
  let morality = tuple_helper "morality" consequence_list in
  let brbs = tuple_helper "brbs" consequence_list in
  let health = tuple_helper "health" consequence_list in
  let social_life = tuple_helper "social_life" consequence_list in
  let friend = main_friend_function decision in 
  Student.update_student student morality gpa social_life health brbs friend

(** [change_tuple_helper] returns " increased by "  if the second value in
    a given tuple is positive, else returns " decreased by "  *)
let change_tuple_helper tuple =
  if snd tuple > 0. 
  then " increased by " 
  else " decreased by "

(** [print_tuple] prints a message to the user which indicates by how much 
    an atrribute of theirs has changed given the tuple of 
    (attribute, change in attribute). *)
let print_tuple tuple =  
  if fst tuple = "gpa" then
    " \n Your " ^ fst tuple ^ change_tuple_helper tuple ^ string_of_float (snd tuple) ^ "!! 
  " 
  else
    " \n Your " ^ fst tuple ^ change_tuple_helper tuple ^ 
    string_of_int (abs (int_of_float (snd tuple))) ^ "!! 
  " (* Prints an int so that there is no situation when it would print
         out "Your social life changed by 5.!!" with a period and then exclamation 
         points which looks weird *)

(** [map_print_helper] is a helper function to print_changes which takes
    in a string list and prints out all of the values in the list.*)
let rec map_print_helper string_list = 
  match string_list with 
  | [] -> ()
  | h :: t -> print_string h; map_print_helper t 

(**takes a decision and choices and prints changes to all attributes,
   including new friends! *)
let print_changes decision choices = 
  let consequence_list = return_consequences decision choices in 
  let string_list = List.map print_tuple consequence_list in
  let new_friend = match_decision_to_friend decision in  
  map_print_helper string_list;
  if new_friend = "NONE" then () else
    print_string("\n You gained a new friend: " ^ new_friend ^ "\n \n")

