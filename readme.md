# CLR document improvment

Using [pdf.tocgen](https://github.com/Krasjet/pdf.tocgen) to add a usable index
to the CLR spec.

Package was installed using PIP, executables are in
~/AppData/Roaming/Python/Python311/Scripts/.

The generated ToC required a little manual cleanup, but otherwise I used the
workflow described in the project's readme in a pretty straightforward fashion.

Unfortunately, adding level 4 headings added numerous false detections. An AWK
script in this directory can be used to filter these out:

```bash
pdftocgen -r recipe.toml  ECMA-335_6th_edition_june_2012.pdf | ./filter-toc.awk > toc
 ```
