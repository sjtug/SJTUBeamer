# SJTUBeamer 🤓

Welcome! 🥳

This is the beamer template exclusively for Shanghai Jiaotong University students to give a speech on group meeting or course project.

## Starting Up 👋

Current document `main.tex` is an example documentation of *How to Use* $\LaTeX$ *to Typeset Thesis*. You could replace the content with the following minimum working example:

<details>

<summary>Expand to show the code block</summary>

```latex
\documentclass[
    % draft,          % draft mode
    aspectratio=169,  % use 16:9 ratio 
]{beamer}
\mode<presentation>

\usetheme[maxplus]{sjtubeamer}
% use maxplus/max/min to change covers.
% use red/blue to change main color.
% use light/dark to change dominate color.
% use the following keywords to make different navigations:
%   miniframes infolines  sidebar
%   default    smoothbars split	 
%   shadow     tree       smoothtree
% use topright/bottomright to change the position of the logo.
% use comma seperated list to use multiple options at the same time.

% \tikzexternalize[prefix=build/]
% To cache the tikz picture, please uncomment the previous line.

\usepackage{biblatex}
\addbibresource{thesis.bib}

\institute{SJTUG}

\title{SJTUBeamer}
\subtitle{A Beamer Template}
\author{SJTUG}
\date{\today} 

\begin{document}

\maketitle

\part{Intro}

\AtBeginSection[]{
  \begin{frame}[plain]
    \sectionpage
  \end{frame}
}

\section{Basics}

\begin{frame}
  \frametitle{Title}
  \paragraph{List} This \alert{slide} contains the following items:
  \begin{itemize}
    \item Item 1
    \item Item 2
    \item Item 3
  \end{itemize}
\end{frame}

\begin{frame}
  \frametitle{Title}
  \framesubtitle{Subtitle}
  \begin{equation}
    x^2+2x+1=(x+1)^2
  \end{equation}
\end{frame}

\section{Blocks}
\begin{frame}
  \frametitle{Some boxes}
  \begin{block}{block}
    This is a box.
    % \cite{<thelegendofjiang>}
  \end{block}
  \begin{alertblock}{alertblock}
    Text.
  \end{alertblock}
  \begin{exampleblock}{exampleblock}
    Text.
  \end{exampleblock}
\end{frame}

\begin{frame}[fragile]          % fragile 
  \frametitle{codeblock}
  \begin{codeblock}[language=c++]{C++ Code}
#include<iostream>

int main(){
  // Console Output
  std::cout << "Hello, SJTU!" << std::endl;
  return 0;
}
  \end{codeblock}
\end{frame}

\part{Bibliography}
\begin{frame}[allowframebreaks]
  \printbibliography[heading=none]
\end{frame}

\makebottom       % create the bottom page

\end{document}
```

</details>

## Usage 🧰

Edit `main.tex` and start to use.

### Template Download & Compilation

* Overleaf
  * Download the development version by clicking "Code - Download Zip".
  * Or download [the latest version](https://github.com/sjtug/SJTUBeamer/releases). Click "Source Code (zip)" to download.
  * Upload to Overleaf.
  * Set to "XeLaTeX" for compilation.
* Local Use
  * Install TeXLive.
  * Run `git clone https://github.com/sjtug/SJTUBeamer/` or `git clone https://mirror.sjtu.edu.cn/git/SJTUBeamer.git/`.
  * Or download the development version by clicking "Code - Download Zip".
  * Or download [the latest version](https://github.com/sjtug/SJTUBeamer/releases). Click "Source Code (zip)" to download.
  * Run `latexmk -xelatex main.tex` to compile
  * VSCode LaTeX Workshop: use “Recipe: latexmk (latexmkrc)” to compile

The current stable version is v3.0.0。You could visit [the release page](https://github.com/sjtug/SJTUBeamer/releases) for the changelog and more details. Generally speaking, a release of SJTUBeamer has the following content:

* `sjtubeamerquickstart.pdf`：SJTUBeamer Quick Start. You could also read the [source code](https://github.com/sjtug/SJTUBeamer/blob/main/src/doc/sjtubeamerquickstart.tex) of the document.
* `sjtubeamer.pdf`: SJTUBeamer User Guide.
* `sjtubeamerdevguide.pdf`: SJTUBeamer Development Guide.
* `sjtulib-talk-max-red.pdf`: `max,red` version of `main.tex`.
* `sjtulib-talk-maxplus-blue.pdf`: `maxplus,blue` version of `main.tex`.
* `sjtulib-talk-maxplus-red.pdf`: `maxplus,red` version of `main.tex`.
* `sjtulib-talk-min-red.pdf`: `min,red` version of `main.tex`.
* `sample-all-covers.pdf`: all covers (title page and bottom page).
* `sjtubeamer-ctan.zip`: the installation package.
* SJTUBeamer source code.

Please use Chrome browser or Adobe Acrobat to open user guide, otherwise there could be display issues.

## Feedback & Contribution 👷

* You could get the repository manifest in [MANIFEST](src/MANIFEST.md).
* For regular users, feel free to ask questions and share ideas in [GitHub Discussions](https://github.com/sjtug/SJTUBeamer/discussions).
* For developers, Feel free to file an issue with [GitHub Issues](https://github.com/sjtug/SJTUBeamer/issues) to submit a bug report or a feature request. At the same time, [PRs](https://github.com/sjtug/SJTUBeamer/pulls) are always welcomed for direct code changes.
* The source code should be modified in `.dtx` files. Then use l3build to generate sty files.
* You could get more implementation details in `sjtubeamerdevguide.pdf`.

The development process is as follows:

* Modify `.dtx` files.
* Run `make generate` and copy the style file to the root.
* Update `main.tex`, and run `make build` for previewing modification.
* Update dev guide, and run `make build-dev` ro compile the doc and run tests.
* (Optional) Run `make format-dev` to format all the files.
* Submit a Pull Request.

New contributors could add your name to the developer list in `sjtubeamerdevguide.tex`.

## Appearance 🧐

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/61653082/160813366-5c7bd98b-dc3c-43ac-9cf4-1cb375228470.jpg">
  <img alt="Red Cover" src="https://user-images.githubusercontent.com/61653082/160813386-8cb98131-0cae-456b-af1e-cec671e5fc8e.jpg">
</picture>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/61653082/160813414-9b43c4b3-4e6d-4f51-9c63-ff7a87eafcf7.jpg">
  <img alt="Blue Cover" src="https://user-images.githubusercontent.com/61653082/160813430-1c7647d4-6346-4fd8-b43f-e156b6234b0e.jpg">
</picture>

## License


* SJTUBeamer is licensed under Apache-2.0.
* SJTUBeamer is licensed under CC-BY-SA 4.0.
* sjtuvi and sjtucover library and related graphics is under [No commercial](https://vi.sjtu.edu.cn/index.php/articles/bulletin/16).
