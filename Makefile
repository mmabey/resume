SHELL=/bin/bash

default:
	@echo "No default target. Compile it yourself."

clean:
	@echo "Removing all LaTeX build files."
	@rm -f {./,sections/,exp/}*.{aux,bbl,blg,log,fdb_latexmk,fls,out,synctex.gz,bcf,run.xml}
