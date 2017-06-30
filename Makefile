project := real_world_machine_learning
prefix  ?= docs

noweb_src    = ${project}.nw
py_src_dir  := src/python/${project}
tex_src_dir := src/tex
py_srcs     := \
	$(dir ${py_src_dir})setup.py \
	$(addprefix ${py_src_dir}/,$(addsuffix .py,\
	ch2 \
	))

# dirname = $(patsubst %/,%,$(dir ${1}))
tangle  = notangle -R$(notdir $@) $< -filter btdefn | cpif $@
weave   = noweave -n -filter btdefn -delay -index -latex $< | cpif $@

.PHONY: all build

all: build ${prefix}/${project}.pdf

${py_srcs}: ${noweb_src}
	${tangle}

${tex_src_dir}/%.tex: %.nw ${tex_src_dir}/%.bib
	${weave}

${prefix}/%.pdf: ${tex_src_dir}/%.tex
	latexmk --shell-escape -pdf -outdir=${prefix} $<
	latexmk -c -outdir=${prefix} $<
	@ rm -fr ${prefix}/$*.{bbl,run.xml}

build: ${py_srcs} default.nix
	@ nix-build
