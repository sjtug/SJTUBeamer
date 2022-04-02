# SJTUBeamer 🤓

Welcome! 🥳

This is the beamer template exclusively for Shanghai Jiaotong University students to give a speech on group meeting or course project.

## Starting Up 👋

Current document `main.tex` is an example documentation of *How to Use LaTeX to Typeset Thesis*. You could replace the content with the following minimum working example:

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
% use the following keywords to make different sidebars:
%   miniframes infolines  sidebar*
%   default    smoothbars split	 
%   shadow     tree       smoothtree

% \tikzexternalize[prefix=build/]
% To cache the tikz picture, please uncomment the previous line.

\usepackage{biblatex}
\addbibresource{thesis.bib}

\institute[SJTUG]{Shanghai Jiao Tong University *nix User Group}

\title{SJTUBeamer}
\subtitle{A Beamer Template}
\author{SJTUG}
\date{\today} 

\begin{document}

\maketitle

\part{Intro}

\AtBeginSection[]{
  \begin{frame}          
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
  \printbibliography
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

The current stable version is v2.6.0。You could visit [the release page](https://github.com/sjtug/SJTUBeamer/releases) for the changelog and more details. Generally speaking, a release of SJTUBeamer has the following content:

* `sjtubeamer.pdf`: SJTUBeamer User Guide。**HIGHLY RECOMMENDED TO READ BEFORE YOU START👍👍👍**
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

* Feel free to file an issue with GitHub Issues. At the same time, PRs are always welcomed.
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

![cover_1](https://user-images.githubusercontent.com/61653082/160813366-5c7bd98b-dc3c-43ac-9cf4-1cb375228470.jpg)
![cover_2](https://user-images.githubusercontent.com/61653082/160813386-8cb98131-0cae-456b-af1e-cec671e5fc8e.jpg)
![cover_3](https://user-images.githubusercontent.com/61653082/160813414-9b43c4b3-4e6d-4f51-9c63-ff7a87eafcf7.jpg)
![cover_4](https://user-images.githubusercontent.com/61653082/160813430-1c7647d4-6346-4fd8-b43f-e156b6234b0e.jpg)

## License


* SJTUBeamer is licensed under Apache-2.0.
* SJTUBeamer is licensed under CC-BY-SA 4.0.
* sjtuvi and sjtucover library and related graphics is under [No commercial](https://vi.sjtu.edu.cn/index.php/articles/bulletin/16).
