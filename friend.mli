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

