# Manifest for sjtubeamer

This file is a listing of all files considered to be part of this package.
It is automatically generated with `l3build manifest`.


## Minimal manifest

The following group lists all the necessary files that required by the runtime.
You could install these files to your TeX distribution or distribute them with
your main document.
### Minimal workset

* vi/
* beamercolorthemesjtubeamer.sty 
* beamerfontthemesjtubeamer.sty 
* beamerinnerthemesjtubeamer.sty 
* beamerouterthemesjtubeamer.sty 
* beamerthemesjtubeamer.sty 
* sjtucover.sty 
* sjtuvi.sty 


## Repository manifest

The following groups list the files included in the development repository of the package.
Files listed with a ‘†’ marker are included in the TDS but not CTAN files, and files listed
with ‘‡’ are included in both.

### Source files

These are source files for a number of purposes, including the `unpack` process which
generates the installation files of the package. Additional files included here will also
be installed for processing such as testing.

 | File                           | Flag | Description                                   |
 | ---                            | ---  | ---                                           |
 | beamerthemesjtubeamer.ins      | ‡    |                                               |
 | beamercolorthemesjtubeamer.dtx | ‡    | sjtubeamer color theme                        |
 | beamerfontthemesjtubeamer.dtx  | ‡    | sjtubeamer font theme                         |
 | beamerinnerthemesjtubeamer.dtx | ‡    | sjtubeamer inner theme                        |
 | beamerouterthemesjtubeamer.dtx | ‡    | sjtubeamer outer theme                        |
 | beamerthemesjtubeamer.dtx      | ‡    | sjtubeamer parent theme                       |
 | sjtucover.dtx                  | ‡    | cover library for sjtubeamer                  |
 | sjtuvi.dtx                     | ‡    | Visual Identity System library for sjtubeamer |

### Typeset documentation source files

These files are typeset using LaTeX to produce the PDF documentation for the package.

 | File                     | Flag | Description                                |
 | ---                      | ---  | ---                                        |
 | sjtubeamer.tex           | ‡    | User Manual for sjtubeamer (Chinese)       |
 | sjtubeamerdevguide.tex   | ‡    | Development Guide for sjtubeamer (English) |
 | sjtubeamerquickstart.tex | ‡    | Quick Start for sjtubeamer (Chinese)       |

### Derived files

**Installation (1/2)** The files created by ‘unpacking’ the package sources. This typically includes
`.sty` and `.cls` files created from DocStrip `.dtx` files.

* beamercolorthemesjtubeamer.sty †
* beamerfontthemesjtubeamer.sty †
* beamerinnerthemesjtubeamer.sty †
* beamerouterthemesjtubeamer.sty †
* beamerthemesjtubeamer.sty †
* sjtucover.sty †
* sjtuvi.sty †

### Graphics resources

**Installation (2/2)** These files are in `vi/` directory ‡. To provide the basic
graphics resources for creating presentations.

* sjtu-vi-dlogo.pdf 
* sjtu-vi-enlogo.pdf 
* sjtu-vi-sjtubadge.pdf 
* sjtu-vi-sjtubg.png 
* sjtu-vi-sjtugate.png 
* sjtu-vi-sjtuphoto.jpg 
* sjtu-vi-vlogo.pdf 
* sjtu-vi-zhlogo.pdf 

### Typeset documents

The output files (PDF, essentially) from typesetting the various source, demo,
etc., package files.

* sjtubeamer.pdf ‡
* sjtubeamerdevguide.pdf ‡
* sjtubeamerquickstart.pdf ‡

### Test files

**Regression Tests**
These files form the test suite for the package. `.lvt` or `.lte` files are the individual
unit tests, and `.tlg` are the stored output for ensuring changes to the package produce
the same output. These output files are sometimes shared and sometime specific for
different engines (pdfTeX, XeTeX, LuaTeX, etc.).

* color.lvt 
* font.lvt 
* inner.lvt 
* outer.lvt 
* sjtuvi.lvt 
* color.tlg 
* font.tlg 
* inner.tlg 
* outer.tlg 
* sjtuvi.tlg 

### Tutorial files

**Unit Tests**
Files included to demonstrate package functionality. And they are also the demo files for the user guide.
These files will be typesetted first before typesetting the documentation source files.
They could be cached in the next round by `l3build cache-demo`.
The cache could be cleaned by `l3build clean-demo`.
To add a demo file, use `l3build add-demo 20`.

* step0.tex 
* step1.tex 
* step10.tex 
* step11.tex 
* step12.tex 
* step13.tex 
* step14.tex 
* step15.tex 
* step16+-.tex 
* step17+_.tex 
* step18+-.tex 
* step19.tex 
* step2.tex 
* step20.tex 
* step21.tex 
* step22.tex 
* step23.tex 
* step24.tex 
* step25.tex 
* step2bd.tex 
* step2bl.tex 
* step2default.tex 
* step2infolines.tex 
* step2miniframes.tex 
* step2shadow.tex 
* step2sidebar.tex 
* step2smoothbars.tex 
* step2smoothtree.tex 
* step2split.tex 
* step2tb.tex 
* step2tree.tex 
* step3.tex 
* step4.tex 
* step5.tex 
* step6+.tex 
* step7+.tex 
* step7s.tex 
* step8+.tex 
* step9+.tex 
* stepalgo.tex 
* stepalgorithm.tex 
* stepdual.tex 


## TDS manifest

The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.

### Source files (TDS)

All files included in the `sjtubeamer/source` directory.

* beamercolorthemesjtubeamer.dtx 
* beamerfontthemesjtubeamer.dtx 
* beamerinnerthemesjtubeamer.dtx 
* beamerouterthemesjtubeamer.dtx 
* beamerthemesjtubeamer.dtx 
* beamerthemesjtubeamer.ins 
* sjtucover.dtx 
* sjtuvi.dtx 

### TeX files (TDS)

All files included in the `sjtubeamer/tex` directory. This directory contains all the files in the **Minimal workset**.

* vi/
* beamercolorthemesjtubeamer.sty 
* beamerfontthemesjtubeamer.sty 
* beamerinnerthemesjtubeamer.sty 
* beamerouterthemesjtubeamer.sty 
* beamerthemesjtubeamer.sty 
* sjtucover.sty 
* sjtuvi.sty 

### Doc files (TDS)

All files included in the `sjtubeamer/doc` directory.

* MANIFEST.md 
* ref.bib 
* sjtubeamer.pdf 
* sjtubeamer.tex 
* sjtubeamerdevguide.pdf 
* sjtubeamerdevguide.tex 
* sjtubeamerquickstart.pdf 
* sjtubeamerquickstart.tex 


## CTAN manifest

The following group lists the files included in the CTAN package.

### CTAN files

* vi/
* MANIFEST.md 
* beamercolorthemesjtubeamer.dtx 
* beamerfontthemesjtubeamer.dtx 
* beamerinnerthemesjtubeamer.dtx 
* beamerouterthemesjtubeamer.dtx 
* beamerthemesjtubeamer.dtx 
* beamerthemesjtubeamer.ins 
* ref.bib 
* sjtubeamer.pdf 
* sjtubeamer.tex 
* sjtubeamerdevguide.pdf 
* sjtubeamerdevguide.tex 
* sjtubeamerquickstart.pdf 
* sjtubeamerquickstart.tex 
* sjtucover.dtx 
* sjtuvi.dtx 


## Online manifest

The following group lists the files included in the online distribution.
You could upload the package to any online plateforms. Compared with
**Minimal workset**, this distribution comes with all the plugins and
quick start guide as the main file.
You could generate the package by going to the root directory and
using the command `make build-online` in the terminal.

### Online files

* contrib/
* build/
* vi/
* beamercolorthemesjtubeamer.sty 
* beamerfontthemesjtubeamer.sty 
* beamerinnerthemesjtubeamer.sty 
* beamerouterthemesjtubeamer.sty 
* beamerthemesjtubeamer.sty 
* ref.bib 
* sjtubeamerquickstart.tex 
* sjtucover.sty 
* sjtuvi.sty 
