open Scenario
open Student

let decision_consequence_list = [("single", [("gpa", 0.2)]);
                                 ("double", [("brb", 2.0); ("social_life", 5.0)]);
                                 ("O Week", [("social_life", 5.0); ("health", 3.0)]);
                                 ("Stay in", [("social_life",  -2.0); ("health", -2.0)]);
                                 ("Look at textbook", [("social_life", -5.0); ("gpa", 0.4)]);
                                 ("Leave without the person", [("social_life", -3.0)]);
                                 ("Help the person home", [("morality", 5.0)]);
                                 ("Snooze", [("gpa", -0.5); ("health", 3.0)]);
                                 ("Go to class", [("gpa", 0.2); ("health", -2.0); ("social_life", 4.0)]);
                                 ("Fun club", [("health", 10.0)]);                       
                                 ("Career club", [("gpa", 0.2); ("brbs", 5.0)]);                    
                                 ("Charity club", [("morality", 6.0)])              
                                ]


let decision_scenario_name = [("Single", "Meet Brad");
                              ("Double", "Meet Brad");
                              ("O Week", "Roommate and Brad"); 
                              ("O Week", "No Roommate and Brad");
                              ("Help the person home", "First Day");
                              ("Leave without the person", "First Day");
                              ("Stay in", "First Day");
                              ("Snooze", "Clubfest");
                              ("Go to class", "Clubfest");
                              ("Fun club", "Halloween");
                              ("Career club", "Halloween");        
                              ("Charity club", "Halloween");
                              ("Study", "Club Meeting");
                              ("Trick-or-treating", "Club Meeting");
                              ("Club", "TBD");
                              ("Hiking", "TBD")]
