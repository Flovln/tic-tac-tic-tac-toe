
type players = Player1 | Player2

type t

val get_player : t -> players -> string

val create : unit -> t

val next : t -> string -> string

val display : string -> unit
