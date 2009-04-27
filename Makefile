########################################
#
#  PDFLATEX Makefile v4
#  JAH after DAW, 2008 
#
#  For Debian or Ubuntu users:
#  sudo apt-get install latex-beamer texlive-pdfetex texlive-latex-extra \
#  			dvi2ps-fontdata-ptexfake texlive-fonts-recommended
#

ALL = paper.pdf
#export TEXINPUTS = ./sty/:

.SUFFIXES:

all: $(ALL)

%.dvi: %.tex %.bbl *.tex
	latex $<
	@echo Checking whether we should rerun LaTeX or not...
	@(grep Rerun $(<:.tex=.log) >/dev/null && latex $<; exit 0)

%.ps: %.dvi
	dvips -t letter -o $@ $<

%.pdf: %.tex %.bbl *.tex
	pdflatex -shell-escape $<
	@echo Checking whether we should rerun LaTeX or not...
	@(grep Rerun $(<:.tex=.log) >/dev/null && pdflatex $<; exit 0)

%.aux: %.tex *.tex
	pdflatex $<

%.bbl: %.bib %.aux
	bibtex paper

tidy:
	@rm -f *.{aux,dvi,log,out,bbl,blg} *~ \#*

clean: tidy
	@-rm -f $(ALL)

words:
	@wc -w *.tex

%.html: %.pdf
	hevea $(NAME)
	imagen $(NAME)