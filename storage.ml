(** This file includes the various scenarios and choices that the
    player can make (and their consequences).

    None of this should be exposed to the client!! It is exposed to implementers
    because it is used in other files. This is why it does not have an mli, and 
    does not show up on makedocs*)
open Student

(** [decision_consequence_list] is a list of the various choices and then
    the various corresponding consequences *)
let decision_consequence_list = [
  (* ("test", [("gpa", 0.0)]); *)
  (** commented out, uncomment this and line 253 and then add "test" to 
                             line 140 in "scenario.ml" in order to add a 
                             convenient option that will bring you to the
                             end screen after the first scenario.!*)
  ("single", [("gpa", 0.2)]);
  ("double", [("brbs", 5.0); ("social_life", 5.0)]);
  ("o Week", [("social_life", 5.0); ("health", 3.0)]);
  ("stay in", [("social_life",  -2.0); ("health", -2.0)]);
  ("look at textbook", [("social_life", -5.0); ("gpa", 0.4)]);
  ("leave without them", [("social_life", -3.0); ("morality", -10.0)]);
  ("help them home", [("morality", 5.0)]);
  ("snooze", [("gpa", -0.5); ("health", 3.0)]);
  ("go to class", [("gpa", 0.2); ("health", -2.0); ("social_life", 4.0)]);
  ("fun club", [("health", 10.0)]);                       
  ("career club", [("gpa", 0.2); ("brbs", 5.0)]);                    
  ("charity club", [("morality", 6.0)]);
  ("study", [("gpa", 0.2); ("social_life", -5.0)]);
  ("go trick or treating", [("gpa", -0.2); ("social_life", 5.0)]);
  ("sign up", [("gpa", 0.2); ("social_life", 5.0)]);
  ("nah I'm good", [("gpa", -0.2); ("social_life", -5.0); ("health", -3.0)]);
  ("do the right thing", [("morality", 10.0)]); 
  ("Screw okies", [("morality", -7.0)]);
  ("unmask the bear man", [("morality", 10.0)]);
  ("make a reddit post about it", 
   [("morality", -7.0); ("social_life", -5.0)]);
  ("attend the social", [("social_life", 10.0); ("health", 5.0)]);
  ("binge watch youtube", [("health", -5.0); ("social_life", -8.0)]);
  ("do some pushups", [("health", 11.0); ("social_life", -8.0)]);
  ("lower the course load",[("health", 5.0); ("gpa", 0.3)]);
  ("keep current course load", 
   [("health", -5.0); ("social_life", -5.0); ("gpa",-0.2)]);
  ("go to dinner", [("health", 7.0); ("social_life", 5.0); ("brbs", -10.0)]);
  ("stay home and be lonely", [("health", -5.0); ("social_life", -5.0)]); 
  ("sacrifice mental health for gpa", [("health", -8.0); ("gpa", 0.5)]); 
  ("fail the assignment", [("health", 8.0); ("gpa", -0.5)]);
  ("join the frisbee team", [("health", 10.0); ("social_life", 10.0)]);
  ("don't join", [("health", -8.0); ("gpa", 0.3)]);
  ("ignore it. It's college", [("morality", 6.0); ("social_life", 4.0)]);
  ("report it to the RA", [("morality", -8.0); ("social_life", -9.0)]);
  ("get a bike", [("health", 8.0); ("brbs", -10.0); ("gpa", 0.2)]);
  ("Keep walking", [("health", 3.0); ("gpa", -0.3)]);
  ("start using the bus pass", [("health", -4.0); ("gpa", 0.2)]);
  ("Accompany your friend", [("social_life", 5.0); ("health", -2.0)]);
  ("Jam out", [("social_life", -5.0); ("health", 2.0)]);
  ("Stop and take a pic with touchdown", [("gpa", -0.3); ("social life", 3.0)]);
  ("Rush to class", [("gpa", 0.5)]);
  ("Cook with roommate", [("social life", 5.0); ("morality", 8.0)]);
  ("Onion rings and chicken tenders from Nasties", 
   [("health", -10.0); ("brbs", -10.0)]);
  ("Build an igloo", [("social life", 5.0); ("gpa", -0.4)]);
  ("Study for prelim", [("gpa", 0.5)]);
  ("Netflix and hot chocolate",[("health", 5.0); ("gpa", -0.4)]);
  ("Take the sign",[("morality", -5.0); ("health", -5.0)]);
  ("Leave it",[("morality", 5.0)]);
  ("Put the sign back",[("morality", 5.0)]);
  ("Keep going",[("morality", -10.0)]);
  ("Visit Denice Cassaro",[("social_life", 2.0)]);
  ("Okenshield's",[("health", 3.0)]);
  ("watch a movie", ["health", 3.0]);
  ("Popcorn",[("health", 10.0)]);
  ("Go back home", [("health", 6.0)]);
  ("Stay in Ithaca", [("social_life", 8.0)]);
  ("Enjoy the great weather",[("gpa", -0.9); ("health", 10.0)]);
  ("Continue to study",[("gpa", 1.0)]);
  ("Rush", [("social_life", 10.0)]);
  ("Don't rush", [("social_life", -3.0)]);
  ("Take the bid", [("brbs", -5.0)]);
  ("Don't take the bid", [("brbs", 2.5)]);
  ("Snuggle up with friends", [("social_life", 1.0)]);
  ("Slide down the slope", [("social_life", 1.0); ("health", -1.0)]);
  ("Watch lectures", [("gpa", 1.5)]);
  ("Talk to a caps counselor", [("health", 2.0)]);
  ("binge on junk food and netflix shows", [("health", -1.0)]);
  ("hang out with friends", [("social_life", 1.5)]);
  ("Go to the career center", [("gpa", 0.2)]);
  ("Just apply next year", [("gpa", -0.1)]);
  ("Stay on campus", [("gpa", 0.1)]);
  ("Go home", [("morality", 4.0)]);
  ("Vacation with friends", [("morality", -2.0); ("social_life", 1.0)]);
  ("go to the slope", [("social_life", 1.5)]);
  ("start studying early", [("gpa", 0.1)]);
  ("sleep", [("health", 1.0)]);
  ("Sneak it in", [("morality", -3.0)]);
  ("Don't sneak it in", [("morality", 3.0)]);
  ("Study most of the time", [("gpa", 0.2)]);
  ("Mix of friends and books", [("gpa", 0.1); ("social_life", 2.0)]);
  ("Don't study at all", [("morality", -3.0)]);
  ("Wait around for a seat", [("morality", -1.0)]);
  ("Study somewhere else", [("morality", 1.0)]);
  ("ice cream class", [("health", -5.0); ("social_life", 7.0)]); 
  ("cs3110", [("health", -3.0); ("social_life", -3.0); ("brbs", 7.0)]);
  ("cs 3110",[("social_life", -5.0); ("gpa", 0.2)]);
  ("commit",[("gpa", 0.2); ("brbs", 5.0)]);
  ("later", [("gpa", -0.2)]);
  ("get a gym pass",[("brbs", -15.0);("health", 6.0)]);
  ("no never going to use it",[("health", -2.0)]);
  ("start your homework",[("gpa", 0.3)]);
  ("watch the office",[("health", 3.0)]);
  ("go to the gym",[("health", 6.0)]);
  ("do laundry",[("health", 3.0)]);
  ("not career fair",[("gpa", 0.3);("brbs", -5.0)]);
  ("career fair",[("brbs", 10.0);("gpa", -0.1)]);
  ("big tech company",[("brbs", 5.0)]);
  ("small start up",[("brbs", 3.0)]);
  ("non profit",[("morality", 10.0)]);
  ("help them",[("morality", 7.0);("social_life", 7.0)]);
  ("i would never",[("social_life", -4.0); ("morality", 0.5)]);
  ("apply to internships",[("brbs", 5.0);("social_life", -2.0);("gpa", -0.1)]);
  ("spend time with friends",[("social_life", 3.0);("gpa", -0.1)]);
  ("work on homework",[("social_life", -2.0); ("gpa", 0.2)]);
  ("football game",[("social_life", 3.0); ("morality", 2.0)]);
  ("cs project",[("social_life", -2.0); ("gpa", 0.2)]);
  ("canada goose jacket",[("brbs", -10.0)]);
  ("jacket from tj maxx",[("brbs", 5.0);]);
  ("freeze",[("health", -10.0)]);
  ("DING DING!", [("social_life", 5.0);("health", 5.0)]);
  ("Stay cozy", [("social_life", -5.0)]);
  ("Vote!", [("morality", 5.0)]);
  ("What is a student assembly?", [("morality", -5.0)]);
  ("Attend the partner social", [("social_life", 10.0); ("gpa", 0.2)]);
  ("I don't need a partner", [("social_life", -5.0); ("gpa", -0.2)]);
  ("Wow! I can't believe you've been teaching CS for 58 years!",[("gpa", 0.4)]);
  ("Are you sure it's not 56?", [("gpa", -0.2)]);
  ("58 years. 58 years. 58 years.", [("gpa", 0.2)]);
  ("59 years. 59 years. 59 years.", [("gpa", 0.4)]);
  ("Celebrate by throwing a party", [("brbs", -5.0); ("social_life", 5.0)]);
  ("Go write some proofs", [("gpa", 0.4); ("social_life", -5.0)]);
  ("Give swae his inhaler", [("morality", 10.0); ("social_life", 5.0)]);
  ("Meh, Black beatles wasn't that good anyway", [("morality", -10.0)]);
  ("I need a nap.", [("gpa", -0.5); ("health", -10.0)]);
  ("I'll study super hard and get all A's (really tho?)", 
   [("gpa", 0.5); ("health", -10.0)]);
  ("Head to collegetown", 
   [("social_life", 10.0); ("health", 12.0); ("morality", 5.0)]);
  ("I have no friends. Stay in the low rises.", 
   [("social_life", -10.0); ("health", -6.0); ("morality", -5.0)]);
  ("Apply for 1110-3110", [("gpa", 0.3)]);
  ("Meh. I don't remember what I learned", [("gpa", -0.3)]);
  ("Broom closet", [("social_life", -5.0); ("brbs", -15.0)]);
  ("Apartment", [("social_life", 10.0)]);
  ("House", [("social_life", 10.0)]);
  ("Biggest room", [("morality", - 7.0); "social_life", -7.0]);
  ("Be a good roommate", [("morality", 7.0); ("social_life", 7.0)]);
  ("Big room", [("morality", - 7.0); "social_life", -7.0]);
  ("Good roommate", [("morality", 7.0); ("social_life", 7.0)]);
  ("Meow", [("health", 15.0)]);
  ("I'm allergic", [("Health",-1.0)]);
  ("Take the offer", [("brbs", - 20.0)]);
  ("Eh, get some electives done", [("gpa", -0.3)]);
  ("Heck yeah!", [("social_life", 10.0)]);
  ("No I have homework", [("gpa",0.1)]);
  ("Follow my destiny", [("brbs", 20.0); ("social_life", 20.0)]);
  ("That's a bit spooky for me", [("social_life", -5.0)]);
  ("Tell your friends", [("social_life",-20.0)]);
  ("It's called secret for a reason!", [("social_life", 5.0)]);
  ("Do that homework", [("gpa", 0.2)]);
  ("Attend a rager", [("social_life", 4.0)]);
  ("Grind time", [("gpa", 0.2)]);
  ("Party time", [("social_life", 4.0)]);
  ("Go pumpkin picking", [("social_life", 10.0)]);
  ("Study instead of going", [("gpa", 0.2)]);
  ("Answer it", [("gpa", 0.2)]);
  ("I'm scared",[("gpa", -0.2)]);
  ("Time to cry",[("social_life",-5.0)]);
  ("Tell them THEY'RE wrong",[("social_life", -5.0)]);
  ("Yell that it was your idea first",[("social_life",-5.0)]);
  ("Cry into your pillow",[("social_life", -5.0)]);
  ("Stuuudy",[("gpa", 0.3)]);
  ("Target",[("gpa", -0.4); ("health", 10.0)]);
  ("Help friend",[("morality", 15.0); ("end", 0.0)]);
  ("Statue",[("health", 14.0); ("end", 0.0)]);
  ("We in this", [("social_life", 5.0); ("brbs",-10.0)]);
  ("Not feeling it",[("social_life", -5.0); ("brbs", 10.0)]);
  ("not tired yet", [("social_life", 5.0); ("health", -3.0)]);
  ("I want to go home", [("social_life", -5.0); ("health", 3.0)]);
  ("They type cute", [("social_life", 5.0)]);
  ("not feelin their vibe", [("social_life", -5.0)]);
  ("get their snap", [("social_life", 5.0)]);
  ("not that interested", [("social_life", -5.0)]);
  ("Spend it with them", [("social_life", 3.0)]);
  ("Spend it alone", [("social_life", -3.0)]);
  ("Find me love", [("social_life", 4.0); ("health", 2.0)]);
  ("Single like a pringle", [("social_life", -4.0); ("health", -3.0)]);
  ("I need help choosing courses", [("gpa", 0.1)]);
  ("I don't need their help", [("gpa", -0.1)]);
  ("I'm falling for them", 
   [("social_life", 4.0); ("health", 3.0); ("brbs", -3.0)]);
  ("I have commitment issues", 
   [("social_life",-4.0); ("health", -3.0); ("brbs", 25.0)]);
  ("Steppin on puddles with my timbs on", [("morality", 10.0)]);
  ("Na na na",[("morality", -10.0)]);
  ("Visit Cornell Health", [("health", 3.0); ("gpa", 0.1)]);
  ("I have no time for that", [("health", -3.0); ("gpa", -0.2)]);
  ("Early senioritis - easy classes", 
   [("health", 5.0); ("morality", -4.0); ("gpa", 0.3)]);
  ("No senioritis, I'm hard working", 
   [("health", -5.0); ("morality", 4.0); ("gpa", -0.1)]);
  ("Bring car", [("health", 6.0); ("brbs", -15.0)]);
  ("Don't bring car", [("health", -2.0)]);
  ("Sleep past your alarm", [("health", 5.0); ("social_life", -3.0)]);
  ("Work on hair and wear your best clothes", [("social_life", 10.0)]);
  ("Get up and go", [("social_life", -1.0)]);
  ("Continue consoling friend", [("morality", 9.0)]);
  ("The conversation's boring, TO THE FIREPIT", 
   [("morality", -7.0); ("social_life", 6.0)]);
  ("I can get new friends", [("health", 5.0); ("social_life", -6.0)]);
  ("Pictures can hold these memories", [("social_life", 6.0)]);
  ("prelims are my priority", [("gpa", 0.6); ("health", -2.0)]);
  ("Go to homecoming", [("gpa", -0.3)]);
  ("break up", [("health", -7.0)]);
  ("go with the flow", [("health", 5.0)]);
  ("Buy pictures", [("brbs", -9.0)]);
  ("It's too expensive", [("brbs", 11.0)]);
  ("graduate early", [("end", 0.0)]); (*ENDING*)
  ("enroll in another semester", [("gpa", 0.4); ("health", 5.0)]);
  ("ski time", [("gpa", -0.2); ("social_life", 8.0)]);
  ("I'm studious", [("gpa", 0.2)]);
  ("Startup", [("brbs", 10.0); ("gpa", -0.1)]);
  ("Meh. I would only work for Google", [("gpa", 0.1)]);
  ("Grad school", [("gpa", 0.3)]); 
  ("Industry", [("brbs", 20.0)]); 
  ("White wine please", [("health", 15.0)]);
  ("I don't drink", [("health", -5.0)]);
  ("Too many steps", [("health", 10.0); ("morality", 10.0)]);
  ("Yes views", [("morality", -10.0)]);
  ("Time to cliff dive", [("social_life", 6.0)]);
  ("I'm scared of the water", [("health", 6.0)]);
  ("SENIOR DAYS", [("social_life", 7.0)]);
  ("Go for the interview", [("brbs", 14.0)]);
  ("Go to class! It's the last day", [("gpa", 0.1)]);
  ("skip", [("social_life", 10.0); ("gpa", -0.01)]);
  ("Actually try", [("gpa", 0.2)]);
  ("Nah, not worth it", [("gpa", -0.2)]);
  ("Spread your wings and fly", [("end", 0.0)]);
]

(** [decision_scenario_name] is a list of choices and then the corresponding 
    next scenario *)
let decision_scenario_name = [
  ("single", "Meet Brad");
  (* ("test", "graduation"); *)
  ("double", "Meet Brad");
  ("o Week", "Roommate and Brad"); 
  ("o Week", "No Roommate and Brad");
  ("help them home", "First Day");
  ("leave without them", "First Day");
  ("stay in", "First Day");
  ("look at textbook", "First Day");
  ("snooze", "Clubfest");
  ("go to class", "Clubfest");
  ("fun club", "Halloween");
  ("test", "ta apps");
  ("career club", "Halloween");        
  ("charity club", "Halloween");
  ("study", "study partner");
  ("sign up", "stir fry");
  ("nah I'm good", "stir fry");
  ("go trick or treating", "stir fry");
  ("do the right thing", "investigation");
  ("unmask the bear man", "social event");
  ("make a reddit post about it", "social event");
  ("Screw okies", "social event");
  ("attend the social", "drop");
  ("binge watch youtube", "drop");
  ("do some pushups", "drop");
  ("lower the course load", "dinner out");
  ("keep current course load", "dinner out");
  ("go to dinner", "office hours");
  ("stay home and be lonely", "office hours");
  ("sacrifice mental health for gpa", "frisbee team");
  ("fail the assignment", "frisbee team");
  ("join the frisbee team", "snitching");
  ("don't join", "snitching");
  ("ignore it. It's college", "transport");
  ("report it to the RA", "transport");
  ("keep walking", "rush");
  ("start using the bus pass", "rush");
  ("get a bike", "rush");
  ("rush", "rush pt 2");
  ("don't rush", "snow slide");
  ("take the bid", "snow slide");
  ("don't take the bid", "snow slide");
  ("Snuggle up with friends", "igloo");
  ("slide down the slope", "igloo");
  ("watch lectures", "igloo");
  ("build an igloo", "winter sign");
  ("study for prelim", "winter sign");
  ("netflix and hot chocolate", "winter sign");
  ("take the sign", "winter sign fall");
  ("Leave it", "seasonal depression");
  ("put the sign back", "seasonal depression");
  ("keep going", "seasonal depression");
  ("talk to a caps counselor", "internship");
  ("binge on junk food and netflix shows", "internship");
  ("hang out with friends", "internship");
  ("go to the career center", "touchdown");
  ("just apply next year", "touchdown");
  ("stop and take a pic with touchdown", "wsh");
  ("rush to class", "wsh");
  ("visit denice cassaro", "nasties run");
  ("okenshield's", "nasties run");
  ("watch a movie", "nasties run");
  ("popcorn", "nasties run"); 
  ("cook with roommate", "spring break");
  ("onion rings and chicken tenders from nasties", "spring break");
  ("stay on campus", "slope day");
  ("go home", "slope day");
  ("vacation with friends", "slope day");
  ("go to the slope", "slope day pt 2");
  ("start studying early", "ew finals");
  ("sleep", "ew finals");
  ("sneak it in", "ew finals");
  ("don't sneak it in", "ew finals");
  ("Study most of the time", "Olin finals");
  ("Mix of friends and books", "Olin finals");
  ("Don't study at all", "post finals");
  ("Wait around for a seat", "post finals");
  ("Study somewhere else", "post finals");
  ("go back home", "classes");
  ("stay in ithaca", "classes");
  ("ice cream class", "Major");
  ("cs 3110", "Major");
  ("commit", "Gym Pass"); 
  ("later", "Gym Pass");
  ("get a gym pass", "Friday Afternoon");
  ("no never going to use it", "Friday Afternoon");
  ("start your homework", "Career Fair Choice"); 
  ("watch the office", "Career Fair Choice");
  ("go to the gym", "Career Fair Choice");
  ("do laundry", "Career Fair Choice");
  ("career fair", "Career Fair");
  ("not career fair", "Academic integrity"); 
  ("big tech company", "Academic integrity"); 
  ("small start up", "Academic integrity"); 
  ("non profit", "Academic integrity");
  ("i would never","applications"); 
  ("help them","applications");
  ("apply to internships","Football Game"); 
  ("spend time with friends","Football Game"); 
  ("work on homework","Football Game");
  ("football game","Canada Goose"); 
  ("cs project","Canada Goose");
  ("canada goose jacket", "Ring the bell");
  ("jacket from tj maxx", "Ring the bell");
  ("freeze", "Ring the bell");
  ("DING DING!", "SA elections"); 
  ("Stay cozy", "SA elections");
  ("Vote!", "Partner Social");
  ("What is a student assembly?", "Partner Social");
  ("Attend the partner social", "57 years");
  ("I don't need a partner", "57 years");
  ("Wow! I can't believe you've been teaching CS for 58 years!", "God");
  ("Are you sure it's not 56?", "58 years");
  ("58 years. 58 years. 58 years.", "inhaler");
  ("59 years. 59 years. 59 years.", "inhaler");
  ("Celebrate by throwing a party", "inhaler");
  ("Go write some proofs", "inhaler");                     
  ("Give swae his inhaler", "finals sophomore");
  ("Meh, Black beatles wasn't that good anyway", "finals sophomore");
  ("I need a nap.", "senior week");
  ("I'll study super hard and get all A's (really tho?)", "senior week");
  ("Head to collegetown", "Ta apps");
  ("I have no friends. Stay in the low rises.", "Ta apps");
  ("Apply for 1110-3110", "where living");
  ("Meh. I don't remember what I learned", "where living");
  ("Broom closet", "adopt cat");
  ("Apartment", "apartment choice");
  ("House", "house choice");
  ("Biggest room", "important class");
  ("Be a good roommate", "important class");
  ("Big room", "important class");
  ("Good roommate", "important class");
  ("Meow", "important class");
  ("I'm allergic", "important class");
  ("Take the offer", "signs");
  ("Eh, get some electives done", "signs");
  ("Heck yeah!", "gates tunnel");
  ("No I have homework", "jr weekend");
  ("Follow my destiny", "secret society");
  ("That's a bit spooky for me", "jr weekend");
  ("Tell your friends", "told friends");
  ("It's called secret for a reason!", "jr weekend");
  ("Do that homework", "pumpkins");
  ("Attend a rager", "pumpkins");
  ("Grind time", "pumpkins");
  ("Party time", "pumpkins");
  ("Go pumpkin picking", "answer question");
  ("study instead of going", "answer question");
  ("Answer it", "did answer");
  ("I'm scared", "did not answer");
  ("Time to cry","finals already");
  ("Tell them THEY'RE wrong","finals already");
  ("Yell that it was your idea first","finals already");
  ("Cry into your pillow","finals already");
  ("Stuuudy","friend pack");
  ("Target","friend pack");
  ("Help friend","all black");
  ("Statue","all black");
  ("We in this", "all black part 2");
  ("Not feeling it", "valentines day 2");
  ("not tired yet", "after party");
  ("I want to go home", "valentines day 2");
  ("They type cute", "after party part 2");
  ("not feelin their vibe", "valentines day 2");
  ("get their snap", "valentines day");
  ("not that interested", "valentines day 2");
  ("Spend it with them", "love");
  ("I'm falling for them", "cs visit");                              
  ("I have commitment issues", "cs visit");
  ("Spend it alone", "cs visit");
  ("Find me love", "cs visit");
  ("Single like a pringle", "cs visit");
  ("I need help choosing courses", "junior slope day");
  ("I don't need their help", "junior slope day");
  ("I'm falling for them", "junior slope day");
  ("I have commitment issues", "junior slope day");
  ("Steppin on puddles with my timbs on", "junior finals");
  ("Na na na", "junior finals");
  ("Visit Cornell Health", "senior classes");
  ("I have no time for that", "senior classes");
  ("Early senioritis - easy classes", "senior car");
  ("No senioritis, I'm hard working", "senior car");
  ("Bring car", "senior pic");
  ("Don't bring car", "senior pic");
  ("Sleep past your alarm", "campfire");
  ("Work on hair and wear your best clothes", "campfire");
  ("Get up and go", "campfire");
  ("Continue consoling friend", "autumn nostalgia");
  ("The conversation's boring, TO THE FIREPIT", "autumn nostalgia");
  ("I can get new friends", "homecoming");
  ("Pictures can hold these memories", "homecoming");
  ("Go to homecoming", "relationship");
  ("prelims are my priority", "relationship");
  ("break up", "senior pic ready 2");
  ("go with the flow", "senior pic ready 2"); 
  ("Buy pictures", "graduate early"); 
  ("It's too expensive", "graduate early"); 
  ("graduate early", "end"); (** ENDING *)
  ("enroll in another semester", "ditch finals");
  ("ski time", "startup");
  ("I'm studious", "startup");
  ("Startup", "grad school");
  ("Meh. I would only work for Google", "grad school");
  ("Grad school", "wines");
  ("Industry", "wines");
  ("White wine please", "tower");
  ("I don't drink", "tower");
  ("Too many steps", "first dam");
  ("Yes views", "first dam");
  ("Time to cliff dive", "last day of classes");
  ("I'm scared of the water", "last day of classes");
  ("SENIOR DAYS", "graduation");
  ("Go for the interview", "graduation");
  ("Go to class! It's the last day", "final finals");
  ("skip", "final finals");
  ("Actually try", "senior days");
  ("Nah, not worth it", "senior days");
  ("Spread your wings and fly", "end")
]

(** [scenario_friends_list] is a list of friends that can be gained at certain
    circumstances *)
let scenario_friends_list = [
  ("DOUBLE", "Sam");
  ("O WEEK", "Brad");
  ("GO TO CLASS", "Jack");
  ("HELP THEM HOME", "Nicola");
  ("FUN CLUB", "Lirinda");
  ("CAREER CLUB", "Maximillian the III");
  ("CHARITY CLUB", "Gandhi");
  ("ATTEND THE SOCIAL", "Sadman");
  ("GET THEIR SNAP", "Charlie")

]

(** [has_prereq] is a list of scenarios that need to be unlocked previously *)
let has_prereq = [
  "Roommate and Brad"; 
  "love";
  "startup";
]

(** [unlock_list] is a list of scenarios that need to be unlocked previously,
    and their special consequences*)
let unlock_list = 
  [("Roommate and Brad", ("double", "No Roommate and Brad"));
   ("love", ("spend it with them", "junior slope day"));
   ("startup", ("career club", "grad school"));
  ]

(** [friend_closeness_list] is a list of the relative closeness of friends at
    different choices *)
let friend_closeness_list = 
  [ ("STAY IN", ("Sam", -5));
    ("O WEEK", ("Sam", 5));
    ("I'M FALLING FOR THEM", ("Charlie", 5));
    ("I HAVE COMMITMENT ISSUES",("Charlie", -5));
    ("STARTUP", ("Maximillian the III", 5));
    ("MEH. I WOULD ONLY WORK FOR GOOGLE",("Maximillian the III", -5))]