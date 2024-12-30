%{

%}

%token LPAREN RPAREN
%token COMMA
%token EQUAL
%token <string> NAME
%token <string> OP
%token <int> INT
%token EOF

%start <unit list> definitions

%%

(* Helpers *)
mark_position(X):
  x = X
   { () }

(* Top-level syntax *)
definitions:
| definition definitions { [] }
| EOF { [] }

definition:
| f = NAME LPAREN x = NAME COMMA y = NAME RPAREN EQUAL expression { () }

/* (x * 1024) + (y - 100) */
expression:
| parenthesised_expression { () }
| expression OP parenthesised_expression { () }

parenthesised_expression:
| LPAREN expression RPAREN { () }
| atom { () }

atom:
| x = NAME { () }
| i = INT  { () }


%%
