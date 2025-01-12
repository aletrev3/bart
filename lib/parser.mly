%{
open Ast
%}

%token LPAREN RPAREN
%token COMMA
%token EQUAL
%token <string> NAME
%token <string> OP
%token <int> INT
%token EOF

%start <def list> definitions

%%

(* Helpers *)
mark_position(X):
  x = X
   { () }

(* Top-level syntax *)
definitions:
| definition definitions { $1 :: $2 }
| EOF { [] }

definition:
| f = NAME LPAREN x = NAME COMMA y = NAME RPAREN EQUAL e = expression { (f,x,y,e) }

/* (x * 1024) + (y - 100) */
expression:
| unary_expression { $1  }
| expression OP unary_expression { Binary( $1 , $2, $3 ) }

unary_expression:
| parenthesised_expression { $1 }
| OP parenthesised_expression { Unary ($1, $2) }

parenthesised_expression:
| LPAREN expression RPAREN { $2 }
| atom { $1 }

atom:
| x = NAME { Var x }
| i = INT  { Integer i }




%%
