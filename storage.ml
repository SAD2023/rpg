
open Student

let decision_consequence_list = [("single", [("gpa", 0.2)]);
                                 ("double", [("brb", 2.0); ("social_life", 5.0)]);
                                 ("o Week", [("social_life", 5.0); ("health", 3.0)]);
                                 ("stay in", [("social_life",  -2.0); ("health", -2.0)]);
                                 ("look at textbook", [("social_life", -5.0); ("gpa", 0.4)]);
                                 ("leave without them", [("social_life", -3.0)]);
                                 ("help them home", [("morality", 5.0)]);
                                 ("snooze", [("gpa", -0.5); ("health", 3.0)]);
                                 ("go to class", [("gpa", 0.2); ("health", -2.0); ("social_life", 4.0)]);
                                 ("fun club", [("health", 10.0)]);                       
                                 ("career club", [("gpa", 0.2); ("brbs", 5.0)]);                    
                                 ("charity club", [("morality", 6.0)]);
                                 ("study", [("end", 0.0)]);
                                 ("go trick or treating", [("end", 0.0)])
                                ]


let decision_scenario_name = [("single", "Meet Brad");
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
                              ("career club", "Halloween");        
                              ("charity club", "Halloween");
                              ("study", "End");
                              ("go trick or treating", "End");
                              ("club", "TBD");
                              ("hiking", "TBD")]

let scenario_friends_list = [
  ("DOUBLE", "Sam");
  ("O WEEK", "Brad");
  ("GO TO CLASS", "Jack");
  ("HELP THEM HOME", "Nicola");
  ("FUN CLUB", "Lirinda");
  ("CAREER CLUB", "Maximillian the III");
  ("CHARITY CLUB", "Gandhi")

]