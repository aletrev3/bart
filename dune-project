(lang dune 3.17)
(using menhir 3.0)

(name bart)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Ale Trejo Reveles" "Daniel Hillerström")

(maintainers "Ale Trejo Reveles")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name bart)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml)
 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
