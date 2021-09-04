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
]{ctexbeamer}
\mode<presentation>

\usetheme[maxplus]{sjtubeamer}
% use maxplus/max/min to change covers.
% use red/blue to change main color.
% use light/dark to change dominate color.
% use the following keywords to make different sidebars:
%   miniframes infolines  sidebar*
%   default    smoothbars split	 
%   shadow     tree       smoothtree
% *siderbar is recommended to be used with max option.

\usepackage[backend=biber,style=gb7714-2015]{biblatex}
\addbibresource{thesis.bib}

\institute[SJTUG]{上海交通大学 Linux 用户组}

\title{SJTUBeamer 幻灯片模板}
\subtitle{SJTUBeamer Template}
\author{SJTUG}
\date{\today} 

\begin{document}

\maketitle

\part{第一部分}

\AtBeginSection[]{
  \begin{frame}          
    \sectionpage
  \end{frame}
}

\section{第 1 节}

\begin{frame}
  \frametitle{标题}
  \paragraph{列表} 这个\alert{幻灯片}有下面几项：
  \begin{itemize}
    \item 第 1 项
    \item 第 2 项
    \item 第 3 项
  \end{itemize}
\end{frame}

\begin{frame}
  \frametitle{标题}
  \framesubtitle{子标题}
  \begin{equation}
    x^2+2x+1=(x+1)^2
  \end{equation}
\end{frame}

\section{第 2 节}
\begin{frame}
  \frametitle{一些盒子}
  \begin{block}{盒子}
    这是一个盒子\cite{thelegendofjiang}
  \end{block}
  \begin{alertblock}{注意}
    注意内容
  \end{alertblock}
  \begin{exampleblock}{示例}
    示例内容
  \end{exampleblock}
\end{frame}

\begin{frame}[fragile]          % fragile 
  \frametitle{代码块}
  \begin{codeblock}[language=c++]{C++代码}
#include<iostream>

int main(){
  // Console Output
  std::cout << "Hello, SJTU!" << std::endl;
  return 0;
}
  \end{codeblock}
\end{frame}

\part{参考文献}
\begin{frame}[allowframebreaks]
  \printbibliography[title=参考文献]
\end{frame}

\makebottom       % create the bottom page

\end{document}
```

</details>

## Usage 🧰

Edit `main.tex` and start to use.

### Template Download & Compilation

* Overleaf
  * Downlaod [the latest version](https://github.com/sjtug/SJTUBeamer/archive/refs/heads/main.zip).
  * Or download [v2.0.0](https://github.com/sjtug/SJTUBeamer/archive/refs/tags/v2.0.0.zip).
  * Upload to Overleaf.
  * Set to "XeLaTeX" for compilation.
* Local Use
  * Install TeXLive.
  * Download [the latest version](https://github.com/sjtug/SJTUBeamer/archive/refs/heads/main.zip).
  * Or Download [v2.0.0](https://github.com/sjtug/SJTUBeamer/archive/refs/tags/v2.0.0.zip).
  * Or clone `git clone https://github.com/sjtug/SJTUBeamer/`.
  * Go through command `latexmk -xelatex main.tex` to compile
  * VSCode LaTeX Workshop: use “Recipe: latexmk (latexmkrc)” to compile

The current stable version is v2.0.0。You could visit [the release page](https://github.com/sjtug/SJTUBeamer/releases/tag/v2.0.0) for the changelog and more details. Generally speaking, a release of SJTUBeamer has the following content:

* `sjtubeamer.pdf`: SJTUBeamer User Guide。**HIGHLY RECOMMENDED TO READ BEFORE YOU START👍👍👍**
* `sjtubeamerdevguide.pdf`: SJTUBeamer Development Guide.
* `sjtulib-talk-max-red.pdf`: `max,red` version of `main.tex`.
* `sjtulib-talk-maxplus-blue.pdf`: `maxplus,blue` version of `main.tex`.
* `sjtulib-talk-maxplus-red.pdf`: `maxplus,red` version of `main.tex`.
* `sjtulib-talk-min-red.pdf`: `min,red` version of `main.tex`.
* `sample-all-covers.pdf`: all covers (title page and bottom page).
* `sjtubeamer-ctan.zip`: the installation package.
* SJTUBeamer source code.

## Feedback & Contribution 👷

* Feel free to file an issue with GitHub Issues. At the same time, PRs are always welcomed.
* The source code should be modified in `.dtx` files. Then use l3build to generate sty files.
* You could get more implementation details in `sjtubeameruserguide.pdf`.

The development process is as follows:

* Modify `.dtx` files.
* Run `make generate` and copy the style file to the root.
* Update `main.tex`, and run `make build` for previewing modification.
* Update dev guide, and run `make build-dev` ro compile the doc and run tests.
* (Optional) Run `make format-dev` to format all the files.
* Release a Pull Request.

New contributors could add your name to the developer list in `sjtubeamerdevguide.tex`.

## Appearance 🧐

![cover-0](https://user-images.githubusercontent.com/4198311/131241659-90f0804b-d0b1-4bb9-b45c-7d3c81ace02a.png)
![cover-1](https://user-images.githubusercontent.com/4198311/131241665-2ced7884-7428-4967-8055-6ce47de7f8bd.png)
![cover-2](https://user-images.githubusercontent.com/4198311/131241668-cc47d9fb-14c4-4681-b95d-98400e9b8d77.png)
![cover-3](https://user-images.githubusercontent.com/4198311/131241669-ccf58f17-d35f-492d-8707-2cfdbd613107.png)

## License


* SJTUBeamer is licensed under Apache-2.0.
* SJTUBeamer is lincesed under CC-BY-SA 4.0.
* sjtuvi and sjtucover library and related graphics is under [No commercial](https://vi.sjtu.edu.cn/index.php/articles/bulletin/16).