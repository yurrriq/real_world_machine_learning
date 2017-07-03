project := real_world_machine_learning
prefix  ?= docs

noweb_src    = ${project}.nw
idr_src_dir := src/idris
py_src_dir  := src/python/${project}
tex_src_dir := src/tex
idr_mods    := \
	Data.ML.Categorical \
	Data.ML.Example \
	Data.ML.Util
idr_srcs    := \
	$(addprefix ${idr_src_dir}/,$(addsuffix .idr,$(subst .,/,${idr_mods})))
py_mods     := \
	ch2
py_srcs     := \
	$(dir ${py_src_dir})setup.py \
	$(addprefix ${py_src_dir}/,$(addsuffix .py,${py_mods}))

# dirname = $(patsubst %/,%,$(dir ${1}))
tangle  = notangle -R$(notdir $@) $< -filter btdefn | cpif $@
weave   = noweave -n -filter btdefn -delay -index -latex $< | cpif $@

.PHONY: all build

all: build ${prefix}/${project}.pdf

${idr_srcs}: ${noweb_src}
	notangle -R'$(subst /,.,$(patsubst ${idr_src_dir}/%.idr,%,$@))' \
	$< | cpif $@

${py_srcs}: ${noweb_src}
	${tangle}

${tex_src_dir}/%.tex: %.nw ${tex_src_dir}/%.bib
	${weave}

${prefix}/%.pdf: ${tex_src_dir}/%.tex
	latexmk --shell-escape -pdf -outdir=${prefix} $<
	latexmk -c -outdir=${prefix} $<
	@ rm -fr ${prefix}/$*.{bbl,run.xml}

${idr_src_dir}/real_world_ml.ipkg: ${noweb_src}
	notangle -R$(notdir $@) $< | cpif $@



build: ${idr_srcs} ${py_srcs} default.nix
	@ nix-build
