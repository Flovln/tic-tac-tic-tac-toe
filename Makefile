RESULT = tic-tac-toe
ML= Grid.ml Board.ml parse.ml Game.ml
MLI= ${ML:.ml=.mli}
SOURCES = $(MLI) $(ML) main.ml
OCAMLMAKEFILE = OCamlMakefile
include $(OCAMLMAKEFILE)
