let start_game () =
    let rec loop () =
        print_endline "Start a new game? Y or N";
        let resp = read_line () in
        if resp = "Y" || resp = "y" then true
        else if resp = "N" || resp = "n" then false
        else loop ()
    in
    loop ()

let main () =
    let rec start () =
        if start_game () then
            let game = Game.create () in
            let player = Game.get_player game Game.Player1 in
            begin
                let rec loop b p =
                    match b with
                    | [] -> start ()
                    | _ -> begin
                        Board.display b;
                        Game.display p;
                        let coord = Parse.parse b in
                        loop (Board.resolve (Board.resolve_grid (Board.place b p coord) coord p) p) (Game.next game p)
                    end
                in
                loop (Board.create ()) player
            end
        else print_endline "Goodbye!"
    in
    start ()

(* Application entry point *)
let () = main ()
