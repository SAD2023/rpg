open Storage 
open Friend
open Student
open Gui
open Graphics

let jack = make_friend "Jack" 5 0
let nicola = make_friend "Nicola" 5 0
let gandhi = make_friend "Gandhi" 5 0
let maximillian = make_friend "Maximillian the III" 5 0
let lirinda = make_friend "Lirinda" 5 0 
let sam = make_friend "Sam" 5 0
let brad = make_friend "Brad" 5 0
let sadman = make_friend "Sadman" 5 0
let charlie = make_friend "Charlie" 5 0
let potential_friend_list =
  [jack; nicola; gandhi; maximillian; lirinda; sam; brad; sadman; charlie]  

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
  | [] -> raise (InvalidInput "Wrong input!")
  | h :: t -> h

(**[tuple_friend_helper] is a helper function thatt extracts the first value of
   the tuple of (decision, friend name) to make a list of decision*)
let rec tuple_friend_helper tuple_list acc = 
  match tuple_list with 
  | [] -> acc
  | h :: t -> tuple_friend_helper t (fst h :: acc) 

let friend_list_filter_helper name (friend:Friend.friend) =  
  name <> Friend.get_name friend

(**Takes the name of a friend and a friend_list and removes the friend with the
   name from the friend_list *)
let remove_friend name (friend_list:Friend.friend list)= 
  List.filter (friend_list_filter_helper name) friend_list

(**Takes a decision and returns the string of the name of a friend or "NONE" *)
let match_decision_to_friend (decision:string) =
  let decision_list = tuple_friend_helper Storage.scenario_friends_list [] in 
  let is_this_a_friend_decision = List.mem decision decision_list in 
  if is_this_a_friend_decision then 
    let list_of_one_friend = 
      List.filter (fun x -> fst x  = decision) Storage.scenario_friends_list in 
    snd (get_element_out_of_list list_of_one_friend)
  else "NONE"

(**takes a string of the name of a friend and returns a list with one
   friend instance *)
let give_friend name_of_friend = 
  try 
    let friend_in_list = 
      List.filter 
        (fun x -> (Friend.get_name x) = name_of_friend) potential_friend_list in  
    friend_in_list
  with InvalidInput "Wrong input!" -> 
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
  prompt = "You are about to move into the low rises. Make sure you're ready \
  \
  for a riot. ~Stay strapped at all times. Do you want a single or double?";
  choices = ["double"; "single"];
  hidden_choices = ["Triple"; "Live with happy dave"];
}

type next_scenarios = scenario list

let list_of_letters = ["A"; "B"; "C"; "D"; "E"]

(** [print_choices] prints the choices pertaining to a given scenario to 
    the terminal. *)
let rec print_choices choices acc =
  match choices with 
  | [] -> ""
  | h :: t ->
    "\n " ^ (List.nth list_of_letters acc) ^ 
    ") " ^ h ^ (print_choices t (acc+1)) 



let return_choices scenario = 
  scenario.choices

(** [print_prompt] prints the prompt pertaining to a given scenario to 
    the terminal. *)
let print_prompt scenario = (*
  ANSITerminal.(print_string [blue] (scenario.prompt ^ "\n")); 
  ANSITerminal.(print_string [yellow] (print_choices scenario.choices 0 ^ "\n"))
*)
  Gui.make_graph_scenario scenario.prompt scenario.choices

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

(* ========================FRESHMAN FALL================================ *)

let meet_brad =  make_scenario "Meet Brad" 
    "You're doing laundry for the first time and you start talking to Brad, who\
    ~lives down the hall. He asks if you want to go to an O-Week event with him \
    ~and some friends. What do you want to do?"
    ["O Week"; "Stay in"; "Look at textbook"; "test"] []

let roommate_and_brad = 
  make_scenario "Roommate and Brad" 
    "Your roommate's friend comes with you, but unfortunately needs a little \
    ~help going home..." 
    ["Help them home"; "Leave without them"] []

let no_roommate_and_brad = 
  make_scenario "No Roommate and Brad" 
    "You see someone (Nicola) and they seem very lost. Do you help them or stay\
    ~with Brad and see if they can find their way by themselves?" 
    ["Help them home"; "Leave without them"] []


let first_day = make_scenario "First Day" 
    "It's the first day of classes! Your alarm buzzes  WAAAY too early. Do you\
    ~snooze or go to your first class?" 
    ["Snooze"; "Go to class"] []

let clubfest = 
  make_scenario "Clubfest" 
    "It's Clubfest! Choose a club and decide whether or not you actually show up\
    ~to the first meeting here:" 
    ["Fun Club"; "Career Club"; "Charity Club"] []

let halloween = make_scenario "Halloween" 
    "It's Halloween! You want to go trick-or-treating, but you have a prelim\
    ~the next morning. Do you:" 
    ["Go Trick or Treating"; "Study"] []

let club_meeting = make_scenario "Club Meeting" 
    "Your club has a meeting! However, your friend invited you to go hiking.\
    ~What do you do?" 
    ["Go to club meeting"; "Go hiking"] []

let study_partner = make_scenario "study partner" 
    "You start studying but the material is really hard! Do you want to sign up\
    ~for the study partner program and find someone else to study with?" 
    ["Sign up"; "Nah I'm good"] []

let stir_fry = make_scenario "stir fry" 
    "You go to Okenshields to see Happy Dave's beautiful face, but you notice an\
    ~ECE major coughing into the stir fry. Perhaps you should investigate this\
    ~grave injustice to the Cornell community. "    
    ["Do the right thing"; "Fuck Okies"] []

let investigation = make_scenario "investigation" 
    "You find a man in a bear costume trying to find a table at Okies (an\
    ~impossible task, as you are aware. Do what you must " 
    ["Unmask the bear man"; "Make a reddit post about it"] []

let club_social = make_scenario "social event" 
    "A club you signed up for is hosting a social event for new members! " 
    ["Attend the social"; "Binge watch youtube"; "do some pushups"] []

let drop = make_scenario "drop" 
    "The deadline to drop a class is almost here! " 
    ["Lower the course load"; "Keep current course load"] []

let dinner = make_scenario "dinner out" 
    "Your friends want to go to Antlers for dinner on Friday. They ask whether\
    ~you want to join them "
    ["Go to dinner"; "Stay home and be lonely"] []

let office_hours = make_scenario "office hours" 
    "Your professor gave you an assignment and didn't teach several concepts\
    ~needed to solve it. Maybe you should go to office hours to figure it out\
    ~(note: it will be crowded like a fish market, you will be #135 on the queue,\
    ~and will likely have a mental breakdown" 
    ["Sacrifice mental health for gpa"; "Fail the assignment"] []

let frisbee = make_scenario "frisbee team" 
    "One of your friends is in the frisbee team and invites you to join. It\
    ~might be some good exercise"
    ["Join the frisbee team"; "Don't join"] []

let snitch = make_scenario "snitching" 
    "You see a beer can in one of your suitemate's wastebasket. What should you\
    ~do?" 
    ["Ignore it. It's college"; "Report it to the RA"] []

let transport =  make_scenario "transport" 
    "It's starting to snow and it's not much harder to walk. You've been late\
    ~to lectures a couple of times already. It might be smart to get a bike"
    ["Get a bike"; "Keep walking"; "Start using the bus pass"] []

let touchdown = make_scenario "Touchdown" 
    "On your way to class, you run into touchdown, Cornell's Big Red Mascot!\
    ~But it seems you're running late." 
    ["Stop and take a pic with touchdown"; "Rush to class"] []

let nasties_run  = make_scenario "Nasties Run" 
    "Your roommate wants to cook dinner tonight to bond together, but you're\
    ~really craving some unhealthy food from nasties." 
    ["Cook with roommate"; "Onion rings and chicken tenders from Nasties"] []

let igloo = make_scenario "Igloo" 
    "It seems like some of your floormates are heading out to make use of the\
    ~huge snowstorm and build an igloo in the CKB quad. Staring at your study\
    ~sheet for a prelim that's in a few days, you wonder what you should do." 
    ["Build an igloo"; "Study for prelim"; "Netflix and hot chocolate"] []

let winter_sign  = make_scenario "Winter Sign" 
    "On your way back to north, you notice a 'no winter maintenance' sign in\
    ~front of you. You know it's a tradition to 'borrow' one of these at least\
    ~once while at Cornell." 
    ["Take the sign"; "Leave it"] []

let winter_sign_fall = make_scenario "Winter Sign Fall" 
    "As soon as you get the sign off the ground, you fall into a slippery, icy\
    ~patch right next to it. Recognizing the irony of what just happened, you\
    ~wonder if you should put the sign back so others can avoid injury" 
    ["Put the sign back"; "Keep going"] []

let wsh = make_scenario "WSH" 
    "Surprisingly, this is the first time you've set foot in Willard Straight\
    ~Hall. Why are you here?"
    ["Visit Denice Cassaro"; "Okenshield's"; "Watch a movie" ] ["Popcorn"]

let post_finals = make_scenario "Post Finals" 
    "You finished your finals early, and some of your friends are staying a few\
    ~days after to hang out stress-free. But your family called the other day\
    ~mentioning how much they miss you, and you realize you miss them alot too" 
    ["Go back home"; "Stay in Ithaca"] []

(*======================= FRESHMAN SPRING ================================= *)

let rush = make_scenario "Rush" 
    "Welcome to a new semester! You are now able to participate in frat sorority\
    ~recruitment. Would you like to rush?" 
    ["Rush"; "Don't rush"] [] 

let rush_2 = make_scenario "Rush pt 2" 
    "YAYYYY, you've gotten a bid!! Do you wish to take it?" 
    ["Take the bid"; "Don't take the bid"] []

let snow_slide = make_scenario "Snow slide" 
    "Let Ithaca snow, let Ithaca snow!!! A snowstorm hits Ithaca which means\
    ~Martha has cancelled classes but more importantly, the slope is covered in\
    ~a nice coat of snow. How do you spend your day of no classes? How about you\
    ~grab a sled and head down the slope!" 
    ["Slide down the slope"; "Snuggle up with friends"; "Watch lectures"] []

let seasonal_depression = make_scenario "Seasonal depression" 
    "You're going through the semester and at a time of prime Ithaca winter\
    ~weather, you start to catch seasonal depression and the semester seems to\
    ~drag. How do you combat it?" 
    ["Talk to a caps counselor"; 
     "binge on junk food and Netflix shows"; "hang out with friends"] []

let internship = make_scenario "Internship" 
    "As you go through the semester, you realize that it would be a great time\
    ~to start looking into internships for the summer break. However, you've\
    ~never done this before and need help on your resume." 
    ["Go to the career center"; "Just apply next year"] []

let spring_break = make_scenario "Spring break" 
    "Your first college spring break! Time to go crazy and destress from a long\
    ~and painful semester of classes. How do you plan on spending it?" 
    ["Stay on campus"; "Go home"; "Vacation with friends"] []

let slope_day = make_scenario "Slope day" 
    "Time to celebrate the end of classes and there's no better way than to\
    ~celebrate at slope day!!! How shall you commemorate the end of the school\
    ~year?"
    ["go to the slope"; "start studying early"; "sleep"] []

let slope_day_2 = make_scenario "Slope day pt 2" 
    "You got your wristband and decided to head down the slope with some\
    ~friends. There are some people checking bags at the top of the slope. What\
    ~are you guys going to do?" 
    ["Sneak it in"; "Don't sneak it in"] []

let finals = make_scenario "Ew finals" 
    "It's that time of the year where students pull all nighters and drown\
    ~gallons of coffee and red bull. There's a brief study period before the\
    ~start of your finals. How do you wish to spend all of that time?" 
    ["Study most of the time"; "Mix of friends and books"; 
     "Don't study at all"] []

let olin_finals = make_scenario "Olin finals" 
    "You decide that the best environment to study for finals is at Olin\
    ~library. However, you go inside and discover that the stacks as well as\
    ~every other room in Olin is packed to the brim with busying students.\
    ~What do you do now?" 
    ["Wait around for a seat"; "Study somewhere else"] []

(* ============================SOPHOMORE FALL============================== *)

let classes = make_scenario "Classes" 
    "It's time to pick out your classes! But oh no! You really want to take the\
    ~Ice Cream class with your friend, but it conflicts with CS 3110, which you\
     ~need for your major!" 
    ["Ice Cream Class"; "CS 3110"] []

let major = make_scenario "Major" 
    "Your advisor asks if you want to commit to your major right away, or wait\
    \
    ~until the end of the year." 
    ["Commit"; "Later"] []

let gym_pass = make_scenario "Gym Pass" 
    "You know that you have a busy semester coming up, but you also think that\
    \
     ~this is the year that you'll get a 7 pack of abs. Should you get a gym \
     ~pass?" 
    ["Get a gym pass"; "No never going to use it"] []

let friday_afternoon = make_scenario "Friday Afternoon" 
    "Wow! You actually have a bit of free time this afternoon! You have plans\
    ~with friends later, but what should you do with your extra free hours?"
    ["Start your homework"; "Watch the Office"; "Go to the gym"; "Do laundry"] []

let career_fair_choice = make_scenario "Career Fair Choice" 
    "The Virtual Career Fair is in a couple of days. However, you also have a\
    ~prelim coming up. You know that you still have to fix up your resume and\
    ~research the companies in attendance, all of which will take away time from\
    ~studying. Do you want to go to the career fair?" 
    ["Not career fair"; "Career fair"] []

let career_fair = make_scenario "Career Fair" 
    "You talk to several companies. Which one do you want to apply for a\
    ~Summer Internship?"
    ["Big tech company"; "Small start up"; "Non profit"] []

let academic_integrity = make_scenario "Academic Integrity" 
    "Your friend left their homework off to the last minute and ask if they can\
    ~see yours to 'check their work'. Do you let them?" 
    ["Help them"; "I would never"]  []

let applications = make_scenario "Applications" 
    "You are really scared that you will be unable to get a summer internship. You\
    ~have some free time this weekend. Do you want to apply for some internships,\
    ~spend time with friends, or do homework?" 
    ["Apply to internships"; "Spend time with friends"; "Work on homework" ] []

let football_game = make_scenario "Football Game" 
    "Cornell is playing Dartmouth in football, but you have a CS project due in a\
    ~couple of days" 
    ["Football game"; "CS Project"] []

let canada_goose = make_scenario "Canada Goose" 
    "It's starting to get really cold out! You need to get a new winter jacket.\
    ~Which should you buy?" 
    ["Canada Goose Jacket"; "Jacket from TJ Maxx"] ["Freeze"]

(* ======================SOPOMORE SPRING ================================ *)

let ring_the_bell = make_scenario "Ring the bell"
    "Your friend asks you to hike into the arboretum and ring the bell, which is\
    ~one of the 161 things every Cornellian should do. It's kinda chilly out tho.\
    ~What're you gonna do?" 
    ["DING DING!"; "Stay cozy"] []

let elections  = make_scenario "SA elections" 
    "You get an email notifying you that the student assembly elections are today!\
    ~Are you going to vote?" 
    ["Vote!"; "What the fuck is a student assembly?"] []

let wicc  = make_scenario "Partner Social" 
    "WICC is holding a partner finding social for your cs class. Having a partner\
    ~might be helpful for the tough assigments!" 
    ["Attend the partner social"; "I don't need a partner"] []

let professor  = make_scenario "57 years" "I have been teaching computer\
    ~science for 57 years - a man walks up to you and says." 
    ["Wow! I can't believe you've been teaching CS for 58 years!"; 
     "Are you sure it's not 56?"] []

let professor2  = make_scenario "58 years" 
    "I have been teaching computer  science for 58 years - the man adds 1 to the\
    ~number. You can feel his immense intellect. You realize that you can not doubt\
    ~his capabilities. He is an instance of the 'god' class. Bow down to his\
    ~highness" 
    ["58 years. 58 years. 58 years."; "59 years. 59 years. 59 years."] []

let mission  = make_scenario "God" 
    "The man smirks. He's impressed by your response. As he walks towards Gates\
    ~doing breadth first search, you receive an email that your major declaration\
    ~has been approved." 
    ["Celebrate by throwing a party"; "Go write some proofs"] []

let inhaler  = make_scenario "inhaler" 
    "You wake up in your bed and realize that Slope day is about to start! You head\
    ~to the area but you hear that apparently swae lee doesn't want to come out and\
    ~perform. People are frantically looking around the stage for something. You \
    ~notice an inhaler on the ground." 
    ["Give swae his inhaler"; "Meh, Black beatles wasn't that good anyway"] []

let finals_sophomore = make_scenario "finals sophomore"
    "It's .... uuuuuugggghhhhhhhhhhh...finals week." 
    ["Fuck me. I need a nap."; 
     "I'll study super hard and get all A's (really tho?)"] []

let senior = make_scenario "senior week" 
    "Finals are over!!!! It's senior week! A lot of people you know are going to\
    ~graduate this year. There won't be a lack of parties or darties!" 
    ["Head to collegetown"; "I have no friends. Stay in the low rises."] []

let ta_apps = make_scenario "Ta apps" 
    "Sophomore year is in the books! Maybe you should apply to be a TA next\
     ~semester."
    ["Apply for 1110-3110"; "Meh. I don't remember what I learned"] []

(* ====================== JUNIOR FALL ================================ *)


let where_living = make_scenario "where living"
    "It's fall of junior year! You probably should have thought about this\
   ~earlier, but do you want to try to find housing on campus somewhere\
   ~(probably in a broom closet or something) or live off campus with fiends?"
    ["Broom closet"; "Apartment"; "House"] []

let apartment_choice = make_scenario "apartment choice"
    "You are going to live in an apartment with your pals! You get to the\
    ~apartment before any of them. Do you choose the biggest room or do you\
    ~wait for them to get there."
    ["Biggest room"; "Be a good roommate"] []

let house_choice = make_scenario "house choice"
    "You are going to live in a house with your pals! You get to the house\
   ~before any of them. Do you choose the biggest room or do you wait for them\
   ~to get there."
    ["Big room"; "Good roommate"] []

let adopt_cat = make_scenario "adopt cat" 
    "The only campus housing you could find was a single in some weird building\
    ~that used to be a chemical storage facility. You are very far away from\
    ~everyone and lonely. Do you want to try and sneak in a cat from the SPCA of\
    ~Thompkins County?"
    ["Meow"; "I'm allergic"] []

let important_class = make_scenario "important class"
    "You need to take this one class to make progress toward your major.\
    ~However, it is completely full. One of your friends offers to sell you\
    ~their spot."
    ["Take the offer"; "Eh, get some electives done"] ["kill them"]

let signs = make_scenario "signs"
    "You are walking to class and you see an illuminati sign etched on the\
    ~ground. You see another carved into a nearby tree! Then another arranged\
    ~in fallen leaves on the ground. Do you keep following them?"
    ["Heck yeah!"; "No I have homework"] []

let gates_tunnel = make_scenario "gates tunnel"
    "You follow the illuminati signs to the basement of Gates, where you find a\
   ~maze of tunnels. You navigate through the maze using Prim's Algorithm. When\
   ~you get to the final node, you see a collection of robed figures through a\
   ~door. Do you go through or turn back?"
    ["Follow my destiny"; "That's a bit spooky for me"] []

let secret_society = make_scenario "secret society"
    "You walk in. You hear applause. 'Welcome, my child' says a voice. It's\
   ~Martha Pollack! Congratulations, you are now a member of one of Cornell's\
   ~secret societies. Too bad you can't put it on your resume."
    ["Tell your friends"; "It's called secret for a reason!"] []

let told_friends = make_scenario "told friends"
    "You told your friends. You were immediately kicked out of the society and\
   ~they don't even believe you.\
   ~Yikes!\
   ~ \
   ~Anyway, the weekend's coming up. What are your plans?"
    ["Do that homework"; "Attend a rager"] []

let jr_weekend = make_scenario "jr weekend"
    "It's the weekend! What are your plans?"
    ["Grind time"; "Party time"] []

let pumpkins = make_scenario "pumpkins"
    "Wow! It's the pretty time of the year! The like 4 days in between t-shirts\
   ~and seventeen jackets! Do you want to go pumpkin picking with your friend\
   ~or study for your upcoming prelim?"
    ["Go pumpkin picking"; "study instead of going"] []

let answer_question = make_scenario "answer question"
    "Your professor ask a question in class. You think you know the answer, but\
    ~you might be wrong. Do you answer it?"
    ["Answer it"; "I'm scared"] []

let did_answer = make_scenario "did answer"
    "Yikes, you answered it and it was very wrong. Eveyone is laughing and \
    ~pointing at you, especially the professor."
    ["Time to cry"; "Tell them THEY'RE wrong"] []

let did_not_answer = make_scenario "did not answer"
    "You didn't answer, and the person sitting next to you did. The professor\
   ~though that their solution was so insightful and elegant that they\
   ~immediately make them a TA, even though they're still taking the class."
    ["Yell that it was your idea first"; "Cry into your pillow"] []

let finals_already = make_scenario "finals already"
    "You know the drill by now. Do you study for finals or spend 8 hours at\
   ~Target procrastinating"
    ["Stuuudy"; "Target"] []

let friend_pack = make_scenario "friend pack"
    "It's time for winter break. You want to have one last look at the beautiful\
   ~statue in front of the Statlerbefore you go, but your friend asks for your\
   ~help packing. What do you do?"
    ["Help friend"; "Statue"] []

(* ====================== JUNIOR SPRING ================================ *)

let all_black = make_scenario "all black"
    "It's the start of a new semester and you want a lit start. The Alpha \  
   ~house is holding their annual all black party at the Southside Community \
   ~Center. You tryna pull up or nah? " 
    ["We in this"; "Not feeling it"] []

let all_black_part_2 = make_scenario "all black part 2"
    "You're with your friends wildin out. You had a great time but the party\
   ~is ending. However, there's an after party at the Alpha house. Do you want\
   ~to continue the fun or retire home early?"
    ["not tired yet"; "I want to go home"] []

let after_party = make_scenario "after party"
    "You pull up to the house and get back to dancing. You turn your head and\
   ~notice someone is looking at you. Sha'll we persuit a dance with our secret\
   ~admirer?"
    ["They type cute"; "not feelin their vibe"] []

let after_party_part_2 = make_scenario "after party part 2"
    "The party is close to ending and people are starting to head out. You had\
   ~a good time dancing with them. Do you want to ask for their snap?"
    ["get their snap"; "not that interested"] []

let valentines_day = make_scenario "valentines day"
    "Ah, the holiday of love. You've been vibing with the person you met at the\
    ~party. Would you like to ask them to be your valentine or just spend the\
    ~day alone?"
    ["Spend it with them"; "Spend it alone"] []

let valentines_day_2 = make_scenario "valentines day 2"
    "You are so desperately alone. But good news is that Cornell is holding a\
   ~Valentines Day matching service!!! Do you want to participate?"
    ["Find me love"; "Single like a pringle"] []

let cs_visit = make_scenario "cs visit"
    "Being that you'll be a senior visit; you think about visiting your CS\
   ~advisor to get advice on plans for the summer and next year. Schedule an\
   ~appointment?"
    ["I need help choosing courses"; "I don't need their help"] []

let love = make_scenario "love"
    "Oop, things seem to be getting serious <3. Would you like to make things\
   ~official with them ?"
    ["I'm falling for them"; "I have commitment issues"] []

let junior_slope_day = make_scenario "junior slope day"
    "SLOPE DAYYYYYY!!! A BOOGIE WITH DA HOODIEEEE is coming to play for slope\
   ~day."
    ["Steppin on puddles with my timbs on"; "Na na na"] []

let junior_finals = make_scenario "junior finals"
    "You are so incredibly stressed out for finals that your skipping meals and\
   ~feeling light headed all the time. What do you want to do?"
    ["Visit Cornell Health"; "I have no time for that"] []

(* ====================== SENIOR FALL ================================ *)

let senior_classes = make_scenario "senior classes" 
    "~It's senior year! It's time to decide whether you're going to catch an \
    ~early case of senioritis or stay hard at work." 
    ["Early senioritis - easy classes"; "No senioritis, I'm hard working"] []

let senior_car = make_scenario "senior car" 
    "~Now that the semester's about to begin, you're considering bringing a car \
    ~to campus. You get excited thinking about all the fun places you can visit \
    ~with a car on campus, but parking is so expensive in Collegetown." 
    ["Bring car"; "Don't bring car"] []

let senior_pic = make_scenario "senior pic" 
    "~It's that time of year! The photography company's in town and it's time to \
    ~take your yearbook picture, but the only appointment they had left was at 7 \
    ~AM." 
    ["Sleep past your alarm"; "Work on hair and wear your best clothes"; 
     "Get up and go"] []

let campfire = make_scenario "campfire" 
    "~A couple of your friends want to go to south hill cider and make s'mores \
    ~around one of their firepits, but you're on the phone consoling a home \
    ~friend with a very important issue. What do you do?"
    ["Continue consoling friend"; 
     "The conversation's boring, TO THE FIREPIT"] []

let autumn_nostalgia = make_scenario "autumn nostalgia" 
    "~Every time you pass by campus, you start to think about all the memories \
    ~and things you're going to miss about it after you graduate. You want to \
    ~spend more time just walking through campus, but your friends always want \
    ~to stay in collegetown."
    ["I can get new friends"; "Pictures can hold these memories"] []

let homecoming = make_scenario "homecoming" 
    "~As the fall semester settles into October, you realize you've never been \
    ~to a Cornell homecoming game. Unfortunately, your professors don't care and \
    ~you have three prelims the same week."
    ["Go to homecoming"; "prelims are my priority"] []

let relationship = make_scenario "relationship" 
    "~You and your significant other are from different sides of the country, \
    ~and you don't know what's going to happen after college."
    ["break up"; "Go with the flow"] []

let senior_pic_ready_2 = make_scenario "senior pic ready 2" 
    "~Your senior pictures are ready! It seems like they've been purposefully \
    ~blurred online and there's a watermark across them. You could buy them to \
    ~fix these issues, but these packages are very expensive."
    ["Buy pictures"; "It's too expensive"] []

let graduate_early = make_scenario "graduate early" 
    "~It seems like alot of your friends are graduating early. You've completed \
    ~all of your course requirements to graduate, and so you can potentially \
    ~graduate earlier. However, another semester would allow you build up your \
    ~gpa a little more, while also just having fun."
    ["graduate early"; "enroll in another semester"] []

let ditch_finals = make_scenario "ditch finals" 
    "~It's the end of your senior fall semester, and your fellow senior friends \
    ~would like to ditch finals week and spend the snowy week traveling to \
    ~Colorado to ski."
    ["Ski time"; "I'm studious"] []

(* ====================== SENIOR SPRING ================================ *)

let grad_school =  make_scenario "grad school" 
    "~Grad school applications are starting to be due. Would you like to apply \
    ~to a grad school?"
    ["Grad school"; "Industry"] []

let startup =  make_scenario "startup" 
    "~Your friend Maximillian the III is making a startup as a side hustle. \
    ~Do you wanna be a part of it? It might take some time out of your semester \
    ~but it'll definitely look good on your resume."
    ["Startup"; "Meh. I would only work for Google"] []

let wines = make_scenario "wines" 
    "~It is your very last semester at Cornell!! This means that this is your \
    ~last chance to take any course before you leave. Everyone talks about \
    ~taking the wine course at Cornell. Shall we raise a glass?" 
    ["White wine please"; "I don't drink"] [] 

let tower = make_scenario "tower" 
    "~It is basically a tradition to climb all 161 steps to the top of McGraw \
    ~Tower. Who knows when you'll even happen to be in Ithaca again; plus the \
    ~views would be amazing. Would you like to climb the tower?" 
    ["Too many steps"; "Yes views"] [] 

let first_dam = make_scenario "first dam" 
    "~The weather is finally nice out and you're feeling relatively stress-free \
    ~as a second semester senior. You realize you've never been to first dam and \
    ~your friends ask if you want to go for a swim"
    ["Time to cliff dive"; "I'm scared of the water"] []

let final_finals = make_scenario "final finals" 
    "~It is your last finals period ever! Do you want to actually try?"
    ["Actually try"; "Nah, not worth it"] []

let last_day_of_classes = make_scenario "last day of classes" 
    "~Finally, it is your last day of classes of your whole college career! \
    ~However, you don't think that your professor is going to say anything \
    ~important, and besides, skipping oneeee class doesn't make a difference, \
    ~right?"
    ["Go to class! It's the last day"; "Skip"] []

let senior_days = make_scenario "senior days" 
    "~It's senior week! Classes and finals are all over and you have the time to \
    ~participate in some amazing events with your fellow seniors before you \
    ~graduate. However, you just got a last minute interview for a full time \
    ~job after college"
    ["SENIOR DAYS"; "Go for the interview"] []



let graduation = make_scenario "graduation" 
    "~*Pomp and circumstances plays* \n\n All of your friends are in fancy robes. \
    ~Ed Helms, Bill Nye, and Martha Pollack are speaking. They point to you and \
    ~say 'alumni pls donate money. we r broke' "
    ["Spread your wings and fly"] []

(** List of all the scenarios *)
let scenario_list = [meet_brad; roommate_and_brad; no_roommate_and_brad;
                     first_day; clubfest; halloween; club_meeting;
                     study_partner; 
                     stir_fry; investigation; club_social; drop; dinner; 
                     office_hours; frisbee; snitch; transport; touchdown; 
                     nasties_run; igloo; winter_sign; winter_sign_fall; wsh;
                     post_finals; finals; rush; rush_2; snow_slide; 
                     seasonal_depression; internship; spring_break; slope_day;
                     slope_day_2; olin_finals; classes; major; gym_pass;
                     friday_afternoon; career_fair_choice; career_fair; 
                     academic_integrity; applications; football_game; 
                     canada_goose; ring_the_bell; elections; wicc; professor;
                     professor2; mission; inhaler; ta_apps; senior; 
                     finals_sophomore; where_living; apartment_choice; 
                     house_choice; adopt_cat; important_class; signs; 
                     gates_tunnel; secret_society; told_friends; jr_weekend; 
                     pumpkins; answer_question; did_answer; did_not_answer;
                     finals_already; friend_pack; all_black; all_black_part_2;
                     after_party; after_party_part_2; valentines_day; 
                     valentines_day_2; cs_visit; love; junior_slope_day;
                     junior_finals; senior_classes; senior_car; senior_pic; 
                     autumn_nostalgia; homecoming; campfire; relationship; 
                     senior_pic_ready_2; graduate_early; ditch_finals;
                     grad_school; wines; tower; first_dam; senior_days; 
                     last_day_of_classes; graduation;
                     final_finals; startup]

let rec go_through_unlocks lst name = 
  match lst with 
  | [] -> raise (InvalidInput name)
  | h :: t -> if fst h = name then (snd h) else (go_through_unlocks t name)

let check_prereq scenario= 
  let name = scenario.name in 
  if List.mem name Storage.has_prereq 
  then go_through_unlocks Storage.unlock_list name else ("NOT IN HERE", "")

(** [next_scenario decision] takes in a Student.decision and then prints out
    the next scenario that corresponds to it *)
let next_scenario decision choices student = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_scenario_name in
    let scenario_name = snd (get_element_out_of_list tuple_list) in
    let one_scenario_list =
      List.filter 
        (fun x -> String.uppercase_ascii x.name = 
                  String.uppercase_ascii scenario_name)
        scenario_list in 
    let next_scenario_element = get_element_out_of_list one_scenario_list in 
    let prereq, alternative = check_prereq next_scenario_element in 
    if prereq = "NOT IN HERE" then next_scenario_element  else 
    if Student.check_decisions (String.uppercase_ascii prereq) student then
      next_scenario_element
    else get_element_out_of_list
        ( List.filter (fun x -> String.uppercase_ascii x.name = 
                                String.uppercase_ascii alternative)
            scenario_list)

  else raise (InvalidInput decision)

(**Takes a decision and returns a list of consequences in the form 
   [("gpa", 0.2)] *)
let return_consequences decision choices player = 
  if List.mem decision choices then 
    let tuple_list = 
      List.filter (filter_helper decision) Storage.decision_consequence_list in 
    let consequence_list =  snd (get_element_out_of_list tuple_list) in
    if fst (get_element_out_of_list consequence_list) = "end" then  
      (Student.final_judgement player;
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

let rec closeness_helper decision list student= 
  match list with 
  | [] -> ("false", 0)
  | h :: t -> if fst h = decision && Student.see_if_you_have_friend (fst (snd h)) 
                   student then snd h else closeness_helper decision t student

let main_closeness_function decision student = 
  let tuple = closeness_helper decision Storage.friend_closeness_list student in 
  if fst tuple = "false" then student else 
    let name_of_friend = fst tuple in 
    let friend_list = Student.friend_list_getter student in 
    let friend = get_element_out_of_list
        (List.filter (fun x -> Friend.get_name x = name_of_friend) friend_list) 
    in 
    let new_friend = Friend.update_friend friend (snd tuple) 0 in  
    let updated_friend_list 
      = new_friend :: (remove_friend (Friend.get_name friend) friend_list) in 
    Student.update_friend_list_only student updated_friend_list


(**Takes a student and a list of consequences in the form [("gpa", 0.2)] and 
   creates a new student instance. *)
let match_consequences student consequence_list decision = 
  let gpa = tuple_helper "gpa" consequence_list in 
  let morality = tuple_helper "morality" consequence_list in
  let brbs = tuple_helper "brbs" consequence_list in
  let health = tuple_helper "health" consequence_list in
  let social_life = tuple_helper "social_life" consequence_list in
  let friend = 
    Student.friend_list_getter student @ (main_friend_function decision) in 
  let new_student =
    (Student.update_student student morality gpa social_life 
       health brbs friend decision) in 
  main_closeness_function decision new_student 


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
    "Your " ^ fst tuple ^ change_tuple_helper tuple ^ 
    string_of_float (snd tuple) ^ "!!" 
  else
    "Your " ^ fst tuple ^ change_tuple_helper tuple ^ 
    string_of_int (abs (int_of_float (snd tuple))) ^ "!!" 
(* Prints an int so that there is no situation when it would print
     out "Your social life changed by 5.!!" with a period and then 
     exclamation points which looks weird *)

(** [map_print_helper] is a helper function to print_changes which takes
    in a string list and prints out all of the values in the list.*)
let rec map_print_helper string_list = 
  match string_list with 
  | [] -> ()
  | h :: t -> Gui.make_graph_addon h; map_print_helper t 

(**takes a decision and choices and prints changes to all attributes,
   including new friends! *)
let print_changes decision choices player = 
  let consequence_list = return_consequences decision choices player in 
  let string_list = List.map print_tuple consequence_list in
  let new_friend = match_decision_to_friend decision in  
  map_print_helper string_list;(
    if new_friend = "NONE" then () else 
      Gui.make_graph_addon ("You gained a new friend: " ^ new_friend ^ "~")
  );
  Unix.sleep 1

let update_age scenario_name student = 
  if scenario_name = "Classes" 
  || scenario_name = "where living" 
  || scenario_name = "senior classes"
  then Student.update_age student
  else student

let return_scenario_name scenario = 
  scenario.name