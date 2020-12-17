
type closeness = int


type friend = {
  name: string;
  closeness: closeness;
}

(** [make_friend] takes in a string value for [name] and integer values
    for [closeness] and generates a new [friend] object with those
    attributes. *)
let make_friend name closeness = {
  name = name;
  closeness = closeness;
}

(** [get_name] extracts the name of [friend]. *)
let get_name friend =
  friend.name

(** [get_closeness] is a getter to extract a friend's closeness. *)
let get_closeness friend = 
  friend.closeness

(** [update_friend] takes in a [friend], a [closeness_add], and 
    returns and updated [friend] object based on the new closeness and worth 
    values. *)
let update_friend friend closeness_add  = 
  {
    name = friend.name;
    closeness = friend.closeness + closeness_add;
  }