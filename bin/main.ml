let () =
  let open Bart in
  let ic = open_in "/dev/stdin" in
  let buf = Lexing.from_channel ic in
  (try
     ignore (Parser.definitions Lexer.token buf)
   with
   | Lexer.Error s ->
      Printf.fprintf stderr "error: %s\n" s
   | Parser.Error ->
      Printf.fprintf stderr "error: parse error\n");
  close_in ic;
  Printf.fprintf stdout "Bye!\n%!"
