type box = Default | Player of string | Resolved of string

type t = box list

let create () = [ Default; Default; Default; Default; Default; Default; Default; Default; Default]
let x_wins () = [ Resolved "\\"; Resolved " "; Resolved "/"; Resolved " "; Resolved "X"; Resolved " "; Resolved "/"; Resolved " "; Resolved "\\"]
let o_wins () = [ Resolved "/"; Resolved "-"; Resolved "\\"; Resolved "|"; Resolved "O"; Resolved "|"; Resolved "\\"; Resolved "-"; Resolved "/"]

let get_box box =
    match box with
    | Default -> "-"
    | Player box -> box
    | Resolved box -> box

let get_index (y, x) = ((y mod 3) * 3) + (x mod 3)

let get_player (grid : t) =
    match (List.nth grid 4) with
    | Resolved player -> Resolved player
    | _ -> Default

let display grid y =
    let index = y * 3 in
    let rec loop lst n =
        match lst with
        | [] -> ()
        | elem :: tail when n = (index + 2) -> print_string (get_box elem)
        | elem :: tail when n >= index ->
               begin 
                   print_string (get_box elem);
                   print_char ' ';
                   loop tail (n + 1)
               end
        | elem :: tail -> loop tail (n + 1)
    in
    loop grid 0

let check grid coord =
    let rec loop lst n =
        match lst with
        | [] -> false
        | elem::tail when n = 0 -> (elem = Default)
        | elem::tail -> loop tail (n - 1)
    in
    loop grid (get_index coord)

let place (grid: t) coord player : t =
    let rec loop lst n =
        match lst with
        | [] -> []
        | elem :: tail when n = 0 -> Player player :: tail
        | elem :: tail -> elem :: loop tail (n - 1)
    in
    loop grid (get_index coord)

let resolve_x (grid: t) =
    let rec in_check lst =
        match lst with
        | Player a :: Player b :: Player c :: _ when a = b && b = c -> true
        | _ :: _ :: _ :: next -> in_check next
        | _ -> false
    in
    in_check grid

let resolve_y (grid: t) =
    let rec in_check = function
        | Player a :: _ :: _ :: Player b :: _ :: _ :: Player c :: _ when a = b && b = c -> true
        | _ :: next -> in_check next
        | _ -> false
    in
    in_check grid

let resolve_z (grid: t) =
    let rec in_left = function
        | Player a :: _ :: _ :: _ :: Player b :: tail when a = b && in_left (Player b :: tail) -> true
        | [c] -> true
        | _ -> false
    in
    let in_right lst =
        let in_check = function
            | Player a :: _ :: Player b :: _ :: Player c :: _ when a = b && b = c -> true
            | _ -> false
        in
        match lst with
        | _ :: _ :: xs -> in_check xs
        | _ -> false
    in
    (in_left grid) || (in_right grid)

let grid_is_full (grid : t) =
    let rec loop = function
        | [] -> true
        | Player _ :: xs -> loop xs
        | _ -> false
    in
    loop grid

let resolve (grid: t) =
    (grid_is_full grid || resolve_x grid || resolve_y grid || resolve_z grid)

