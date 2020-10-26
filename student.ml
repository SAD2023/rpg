

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
}

let initial name = 
  {
    name = name;
    age = 18;
    morality = 0.0;
    gpa = 0.0;
    social_life= 0.0;
    health = 0.0;
    brbs= 0.0;
  }

let print_characteristics student = 
  print_string ("Name: " ^ student.name ^ "\n");
  print_string ("Age: " ^ string_of_int student.age ^ "\n");
  print_string ("Morality: " ^ string_of_float student.morality ^ "\n");
  print_string ("GPA: " ^ string_of_float student.gpa ^ "\n");
  print_string ("Social Life: " ^ string_of_float student.social_life ^ "\n");
  print_string ("Health: " ^ string_of_float student.health ^ "\n");
  print_string ("BRBs: " ^ string_of_float student.brbs ^ "\n")



let update_student student morality gpa social_life health brbs = 
  {
    name = student.name;
    age = student.age;
    morality = student.morality +. morality;
    gpa = student.gpa +. gpa;
    social_life = student.social_life +. social_life;
    health = student.health +. health;
    brbs = student.brbs +. brbs;
  }


let judgement student = 
  print_string " \n Hmm... time to judge your character! \n";
  print_string "First, let's look at your gpa. ";
  if student.gpa <= 1.5 then print_string ("ew your gpa is " ^ (string_of_float student.gpa) ^ " Move to info sci \n \n") 
  else print_string ("wow your gpa is " ^ (string_of_float student.gpa) ^  " Walker White would be proud! \n \n");

  print_string "Let's see how scummy you are. \n";
  if student.morality <= 30.0 then print_string 
      "Heh. You're kind of a mean person. I have an internship for you at Goldman Sachs \n \n" 
  else print_string "You're a decent human it seems. Boring \n \n";

  print_string "How's that gym membership going? \n";
  if student.health <= 50.0 then print_string 
      "You're definitely a cs major. Please take a shower. \n \n" 
  else print_string "You're a fine human specimen. \n \n";


  print_string "Let's see how rich your dad is. \n";
  if student.brbs <= 50.0 then print_string (
      "You're broke. Get a job. You only have " ^ (string_of_float student.brbs) ^ " brbs left. \n \n")
  else print_string ("You're ballin! You have " ^ (string_of_float student.brbs) ^ " brbs left. \n \n");


  print_string "Got any friends? \n";
  if student.social_life <= 40.0 then print_string 
      "Get some friends loser \n \n"
  else print_string ("Oh ma gosh you're so popular... \n \n");

