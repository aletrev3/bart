type expr = Integer of int
          | Var of string
          | Unary of string * expr
          | Binary of expr * string * expr

type def = string * string * string * expr
