noweb_src = real_world_machine_learning.nw

srcs := \
	ch2.py

tangle = notangle \
	-R$@ $< \
	-filter btdefn \
	| cpif real_world_machine_learning/$@

weave  = noweave \
	-n \
	-filter btdefn \
	-delay \
	-index \
	-latex $< \
	| cpif $@

.SUFFIXES: .tex .pdf
.tex.pdf: ; latexmk --shell-escape -pdf -outdir=tex $<

.PHONY: all build

all: build docs/real_world_machine_learning.pdf

${srcs}: ${noweb_src} ; ${tangle}

tex/%.tex: %.nw tex/%.bib ; ${weave}

docs/%.pdf: tex/%.pdf
	@ mkdir -p $(dir $@)
	@ mv $< $@

build: ${srcs} # default.nix
	@ nix-build
