LATEXMK=latexmk
LATEXMK_ARGS=-halt-on-error -lualatex -shell-escape -synctex=1 -time -interaction=nonstopmode -file-line-error

.PHONY:
build:
	$(LATEXMK) main.tex $(LATEXMK_ARGS)

clean:
	$(LATEXMK) -c
