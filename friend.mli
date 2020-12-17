(** Representation of a given friend and their various attributes

    This module represents the data stored for a given friend of a player, as
    well as their closeness, and the ability to undate attributes. *)


(** [friend] The player gains friends along their Cornell journey. They can be
    obtained through classes, social interactions, residential life etc.
    Each time they gain a friend, the friend is added to their list of friends,
    and every time they lose a friend, that is removed from the friend list.*)
type friend

(** On a scale of 1 - 5.
    After every 10 or so scenarios, the closeness decreases, and the player must
    spend time with the friend. If the closess gets  to 0, they lose the friend.
*)
type closeness = int



(** [make_friend] takes in a string value for [name] and integer values
    for [closeness] and [worth] and generates a new [friend] object with those
    attributes. *)
val make_friend: string -> closeness ->  friend

(** [get_name] returns the name of [friend]. *)
val get_name: friend -> string

(** [update_friend] takes in a [friend], a [closeness_add], and a [worth] and 
    returns and updated [friend] object based on the new closeness and worth 
    values. *)
val update_friend: friend -> closeness ->  friend

(** [get_closeness] returns the closeness of a [friend] *)
val get_closeness: friend -> closeness