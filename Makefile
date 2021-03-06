MODULES= main student scenario friend scrambler storage author gui hangman wordsearch
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=main.mli student.mli scenario.mli friend.mli scrambler.mli author.mli gui.mli hangman.mli wordsearch.mli
TEST=test.byte
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind -pkg graphics

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST)

play:
	$(OCAMLBUILD) $(MAIN) && ./$(MAIN)

zip:
	zip game.zip *.ml* *.json _tags Makefile INSTALL.txt LOC.txt
	
docs: docs-public docs-private
	
docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal -package graphics\
		-html -stars -d doc.public $(MLIS)

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal -package graphics \
		-html -stars -d doc.private \
		-inv-merge-ml-mli -m A $(MLIS) $(MLS)

clean:
	ocamlbuild -clean
	rm -rf doc.public doc.private game.zip