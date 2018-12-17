type box = Default | Player of string | Resolved of string

type t = box list

val create : unit -> t
val x_wins : unit -> t
val o_wins : unit -> t

val get_player : t -> box

val display : t -> int -> unit

val check : t -> int * int -> bool

val place : t -> int * int -> string -> t

val resolve_y : t -> bool

val resolve_x : t -> bool

val resolve_z : t -> bool

val resolve : t -> bool
