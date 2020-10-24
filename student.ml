
type age = int

type name = string

type morality = int 

type gpa = float

type social_life = int

type health = int

type brbs = int

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
    morality = 0;
    gpa = 0.0;
    social_life= 0;
    health = 0;
    brbs= 0;
  }

let print_characteristics student = 
  print_string ("Name: " ^ student.name ^ "\n");
  print_string ("Age: " ^ string_of_int student.age ^ "\n");
  print_string ("Morality: " ^ string_of_int student.morality ^ "\n");
  print_string ("GPA: " ^ string_of_float student.gpa ^ "\n");
  print_string ("Social Life: " ^ string_of_int student.social_life ^ "\n");
  print_string ("Health: " ^ string_of_int student.health ^ "\n");
  print_string ("BRBs: " ^ string_of_int student.brbs ^ "\n");

  (** 
     let update_student student morality gpa social_lfe health brbs = 0 in 0
  *)
