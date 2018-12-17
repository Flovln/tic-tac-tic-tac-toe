type players = Player1 | Player2

type t = {p1 : string; p2 : string }
 
let get_player game index =
    match index with
    | Player1 -> game.p1
    | Player2 -> game.p2

let create () = {p1 = "O"; p2 = "X"}

let next game player =
    if player = game.p1 then game.p2 else game.p1

let display player =
    print_string "\x1b[35m";
    print_string player;
    print_string "\x1b[0m";
    print_endline "'s turn to play."
