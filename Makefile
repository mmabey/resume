SHELL=/bin/bash
COMPILE=latexmk -f -g -pdf -silent

default:
	@echo "Please specify a target: cv, resume, clean"

cv:
	@echo "Compiling CV"
	@$(COMPILE) CV_*.tex ;\
	if [ $$? -eq 0 ] ;\
	then echo ; echo "CV successfully compiled" ; echo ;\
	else echo ; echo "ERRORS encountered while compiling. Check the .log file for more info." ; echo ;\
	fi

resume:
	@echo "Compiling Resume"
	@$(COMPILE) Resume_*.tex ;\
	if [ $$? -eq 0 ] ;\
	then echo ; echo "Resume successfully compiled" ; echo ;\
	else echo ; echo "ERRORS encountered while compiling. Check the .log file for more info." ; echo ;\
	fi

clean:
	@echo "Removing all LaTeX build files."
	@rm -f {./,sections/,exp/}*.{aux,bbl,blg,dvi,log,fdb_latexmk,fls,out,synctex.gz,bcf,run.xml}

date:
	@echo "Updating the revision date in resume.cls to today."
	@sed -r -i `tmpdate=\`date +%Y\\\\\\\/%m\\\\\\\/%d\`; echo "s/(^\\\\\\\\ProvidesClass\{resume\}\[)[0-9\/]{10}(.*\$$)/\1$${tmpdate}\2/;"` resume.cls
