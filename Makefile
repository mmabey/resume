default:
	echo "No default target. Compile it yourself."

clean:
	rm -f *.aux *.bbl *.blg *.log *.fdb_latexmk *.fls *.out *.synctex.gz
	rm -f sections/*.aux sections/*.bbl sections/*.blg sections/*.log sections/*.fdb_latexmk sections/*.fls sections/*.out sections/*.synctex.gz
