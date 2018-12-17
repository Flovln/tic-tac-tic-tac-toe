type coord = int * int

type t = Grid.t list

let create () =
  let rec loop n =
    if n > 0 then Grid.create () :: loop (n - 1)
    else []
  in
  loop 9

let display main =
  let rec lines head =
      let rec loop board y x =
          match board with
          | [elem] when y = 2 && x = 2 ->
                  begin
                      Grid.display elem y;
                      print_char '\n'
                  end
          | elem :: tail when y = 2 && x = 2 ->
                  begin
                      Grid.display elem y;
                      print_endline "\n---------------------";
                      lines tail
                  end
          | elem :: tail when x = 2 ->
                  begin
                      Grid.display elem y;
                      print_char '\n';
                      loop head (y + 1) 0
                  end
          | elem :: tail ->
                  begin
                      Grid.display elem y;
                      print_string " | ";
                      loop tail y (x + 1)
                  end
          | _ -> ()
      in
      loop head 0 0
  in
  lines main

let get_grid_id (y, x) = ((y / 3) * 3) + (x / 3)


let resolve_grid board coord player =
    let rec loop lst n =
        match lst with
        | [] -> []
        | elem :: tail when n = 0 && Grid.resolve elem -> begin
            print_string "\x1b[33m";
            print_string player;
            print_string " wins grid ";
            print_int ((get_grid_id coord) + 1);
            print_endline "!\x1b[0m\n";
            if player = "X" then
                (Grid.x_wins () :: tail)
            else Grid.o_wins () :: tail
        end
        | elem :: tail -> elem :: loop tail (n - 1)
    in
    loop board (get_grid_id coord)

let rec _compare (somes : Grid.box list) =
    match somes with
    | Resolved a :: Resolved b :: xs when a = b -> _compare (Resolved b :: xs)
    | Resolved x :: [] -> true
    | _ -> false

let resolve_x (grid: t) =
    let rec in_check lst =
        match lst with
        | a :: b :: c :: _ when _compare [Grid.get_player a; Grid.get_player b; Grid.get_player c] -> true
        | _ :: _ :: _ :: next -> in_check next
        | _ -> false
    in
    in_check grid

let resolve_y (board: t) =
    let rec in_check = function
        | a :: _ :: _ :: b :: _ :: _ :: c :: _ when _compare [Grid.get_player a; Grid.get_player b; Grid.get_player c] -> true
        | _ :: next -> in_check next
        | _ -> false
    in
    in_check board

let resolve_z (board: t) =
    let rec in_left = function
        |  a :: _ :: _ :: _ :: b :: tail when _compare [Grid.get_player a; Grid.get_player b] -> in_left (b :: tail)
        | [c] -> true
        | _ -> false
    in
    let in_right lst =
        let in_check = function
            | a :: _ :: b :: _ :: c :: _ when _compare [Grid.get_player a; Grid.get_player b; Grid.get_player c] -> true
            | _ -> false
        in
        match lst with
        | _ :: _ :: xs -> in_check xs
        | _ -> false
    in
    (in_left board) || (in_right board)

let board_is_full (board : t) =
    let rec loop = function
        | [] -> true
        | x :: xs when _compare [Grid.get_player x] -> loop xs
        | _ -> false
    in
    loop board

let resolve board player =
    if (board_is_full board || resolve_z board || resolve_x board || resolve_y board) then
        begin
            print_string "\x1b[36m\n";
            print_string player;
            print_endline " wins the game!";
            print_string "\x1b[0m\n";
            display board;
            print_char '\n';
            []
        end
    else
        board

let check board coord =
    let rec loop lst n =
        match lst with
        | [] -> false
        | elem :: tail when n = 0 -> Grid.check elem coord
        | elem :: tail -> loop tail (n - 1)
    in
    loop board (get_grid_id coord)

let place (board: t) player coord : t =
    let rec loop lst n =
        match lst with
        | [] -> []
        | elem :: tail when n = 0 -> (Grid.place elem coord player) :: tail
        | elem :: tail -> elem :: loop tail (n - 1)
    in
    loop board (get_grid_id coord)
