

type closeness = int

type worth = int

type friend = {
  name: string;
  closeness: closeness;
  worth: worth;
}

let make_friend name closeness worth = {
  name = name;
  closeness = closeness;
  worth = worth;
}
(**try to remove this later sometimes *)
let acc remove_friend name friend_list acc= 
  match friend_list with 
  | [] -> acc
  | h :: t -> if h.name = name then remove_friend name t acc else 
      remove_friend name t (h::acc)

(**takes a friend instance and returns the name *)
let get_name friend =
  friend.name

let get_closeness friend = 
  friend.closeness

(**takes a friend and updates their closeness and worth *)
let update_friend friend closeness_add worth = 
  {
    name = friend.name;
    closeness = friend.closeness + closeness_add;
    worth = friend.worth + worth 
  }