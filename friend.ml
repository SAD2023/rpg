

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

(**takes a friend instance and returns the name *)
let get_name friend =
  friend.name
