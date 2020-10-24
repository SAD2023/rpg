
open Student

let decision_consequence_list = [("single", [("gpa", 0.2)]);
                                 ("double", [("brb", 2.0); ("social_life", 5.0)]);
                                 ("o Week", [("social_life", 5.0); ("health", 3.0)]);
                                 ("stay in", [("social_life",  -2.0); ("health", -2.0)]);
                                 ("look at textbook", [("social_life", -5.0); ("gpa", 0.4)]);
                                 ("leave without the person", [("social_life", -3.0)]);
                                 ("help the person home", [("morality", 5.0)]);
                                 ("snooze", [("gpa", -0.5); ("health", 3.0)]);
                                 ("go to class", [("gpa", 0.2); ("health", -2.0); ("social_life", 4.0)]);
                                 ("fun club", [("health", 10.0)]);                       
                                 ("career club", [("gpa", 0.2); ("brbs", 5.0)]);                    
                                 ("charity club", [("morality", 6.0)])              
                                ]


let decision_scenario_name = [("single", "Meet Brad");
                              ("double", "Meet Brad");
                              ("o Week", "Roommate and Brad"); 
                              ("o Week", "No Roommate and Brad");
                              ("help them home", "First Day");
                              ("leave without the person", "First Day");
                              ("stay in", "First Day");
                              ("snooze", "Clubfest");
                              ("go to class", "Clubfest");
                              ("fun club", "Halloween");
                              ("career club", "Halloween");        
                              ("charity club", "Halloween");
                              ("study", "Club Meeting");
                              ("trick-or-treating", "Club Meeting");
                              ("club", "TBD");
                              ("hiking", "TBD")]
