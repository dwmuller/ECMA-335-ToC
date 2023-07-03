# A much improved PDF ToC for the ECMA-335 document

This is a quick git repo to save off and share some work that I spent far too
much time on.

The ECMA-335_*_out.pdf file contains a version of the specification with the
improved ToC.

To reproduce it, you'll need Python already installed. Install
[pdf.tocgen](https://github.com/Krasjet/pdf.tocgen) using PiP, as described in
that project. (Many thanks to Krasjet for that tool.)

On my Windows system, the executables ended up in
~/AppData/Roaming/Python/Python311/Scripts/, which I prepended to my path for
this work.

Follow the workflow described for pdf.tocgen, but use the AWK file in this
project to massage the ToC output before using it to modify the PDF.

```bash
pdftocgen -r recipe.toml ECMA-335_6th_edition_june_2012.pdf | ./filter-toc.awk > toc
pdftocio -t toc ECMA-335_6th_edition_june_2012.pdf
 ```
