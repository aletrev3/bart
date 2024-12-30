{
  open Parser

  exception Error of string
}

let lname = ( ['a'-'z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9' '\'']*
            | ['_' 'a'-'z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9' '\'']+)

let uname = ['A'-'Z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9' '\'']*

let name = lname | uname

let hexdig = ['0'-'9' 'a'-'f' 'A'-'F']

let int = ['0'-'9'] ['0'-'9' '_']*

let xxxint =
    ( ("0x" | "0X") hexdig (hexdig | '_')*
    | ("0o" | "0O") ['0'-'7'] ['0'-'7' '_']*
    | ("0b" | "0B") ['0' '1'] ['0' '1' '_']*)


let operator = ['*' '+' '-' '/' '|' '~' '^' '%']

rule token = parse
  | '\n'                { Lexing.new_line lexbuf; token lexbuf }
  | [' ' '\r' '\t']     { token lexbuf }
  | "#"                 { comment lexbuf }
  | int                 { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | xxxint              { try
                            INT (int_of_string (Lexing.lexeme lexbuf))
                          with Failure _ -> raise (Error "Invalid integer constant")
                        }
  | name                { NAME (Lexing.lexeme lexbuf) }
  | operator            { OP (Lexing.lexeme lexbuf) }
  | '('                 { LPAREN }
  | ')'                 { RPAREN }
  | ','                 { COMMA }
  | '='                 { EQUAL }
  | eof                 { EOF }
and comment = parse
  | '\n'                { Lexing.new_line lexbuf; token lexbuf }
  | _                   { comment lexbuf }
  | eof                 { EOF }

{
  let read_file parser fn =
  try
    let fh = open_in fn in
    let lex = Lexing.from_channel fh in
    lex.Lexing.lex_curr_p <- {lex.Lexing.lex_curr_p with Lexing.pos_fname = fn};
    try
      let terms = parser lex in
      close_in fh;
      terms
    with
      (* Close the file in case of any parsing errors. *)
      Error err -> close_in fh; raise (Error err)
  with
    (* Any errors when opening or closing a file are fatal. *)
    Sys_error msg -> raise (Error msg)
}