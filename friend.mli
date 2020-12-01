(** The player gains friends along their Cornell journey. They can be obtained
    through classes, social interactions, residential life etc.
    Each time they gain a friend, the friend is added to their list of friends,
    and every time they lose a friend, that is removed from the friend list.*)
type friend

(** On a scale of 1 - 5.
    After every 10 or so scenarios, the closeness decreases, and the player must
    spend time with the friend. If the closess gets  to 0, they lose the friend.
*)
type closeness = int

(** How valuable they are as a friend.
    Depends on the number of connections they have.
    integer from 1 - 100. *)
type worth = int

(** [make_friend] takes in a string value for the name and integer values
    for closeness and worth and generates a new friend object with those
    attributes. *)
val make_friend: string -> closeness -> worth -> friend

(** [get_name] is a getter to extract a friend's name. *)
val get_name: friend -> string

(** [update_friend] takes in a friend, a closeness, and a worth and 
    updates the previous friend object based on the new closeness and worth 
    values. *)
val update_friend: friend -> closeness -> worth -> friend

(** [get_closeness] is a getter to extract a friend's closeness. *)
val get_closeness: friend -> closeness