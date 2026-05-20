# SJTUBeamer 🤓

[![TeXPage](https://img.shields.io/badge/SJTUBeamer-TeXPage-495A80)](https://www.texpage.com/template/c0decdfd-ca66-4f4a-807d-5217f729dcfa)
[![Overleaf](https://img.shields.io/badge/SJTUBeamer-Overleaf-098842)](https://www.overleaf.com/latex/templates/sjtubeamer/dgvrnpndrtjh)
[![discussions](https://img.shields.io/github/discussions/sjtug/SJTUBeamer)](https://github.com/sjtug/SJTUBeamer/discussions)
[![Build](https://github.com/sjtug/SJTUBeamer/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/sjtug/SJTUBeamer/actions/workflows/build.yml)

欢迎使用 SJTUBeamer! 🥳

SJTUBeamer 是上海交通大学的非官方 Beamer 模版。您可以使用 SJTUBeamer 制作幻灯片，展示您的成果。

这个仓库中包含 SJTUBeamer 所使用的宏包 `sjtubeamer`，以及一个示例文档。

## 快速上手 👋

目前的 `main.tex` 是一个示例文档《如何使用 LaTeX 排版论文》。您可以将里面的内容替换掉。下面是一个最简示例：

<details>

<summary>点击展开代码片段</summary>

> Prism 需要首行的魔术注释来变更编译程序，使用 beamer 文档类不编写中文的情况下可以省略该行以使用默认的 pdfLaTeX 编译程序。

```latex
% !TeX program = xelatex

\documentclass[
    % draft,          % 草稿模式
    aspectratio=169,  % 使用 16:9 比例
    % fontset=ubuntu, % 在 Prism 平台需要添加该字体选项
]{ctexbeamer}
\mode<presentation>

\usetheme[min]{sjtubeamer}
% 使用 maxplus/max/min 切换标题页样式
% 使用 red/blue 切换主色调
% 使用 light/dark 切换亮/暗色模式
% 使用外样式关键词以获得不同的边栏样式
%   miniframes infolines  sidebar 
%   default    smoothbars split	 
%   shadow     tree       smoothtree
% 使用 topright/bottomright 切换徽标位置
% 使用逗号分隔列表以同时使用多种选项

% \tikzexternalize[prefix=build/]
% 如果您需要缓存 tikz 图像，请取消注释上一行，并在编译选项中添加 -shell-escape。

\usepackage[backend=biber,style=gb7714-2015]{biblatex}
\addbibresource{thesis.bib}

\institute[SJTUG]{上海交通大学 Linux 用户组} % 组织

\title{SJTUBeamer 幻灯片模板}         % 标题
\subtitle{SJTUBeamer Template}       % 副标题
\author{SJTUG}                       % 作者
\date{\today}                        % 日期  

\begin{document}

\maketitle                           % 创建标题页

\part{第一部分}

% 使用节目录
\AtBeginSection[]{
  \begin{frame}
    % \tableofcontents[currentsection,hideallsubsections]  % 传统节目录             
    \sectionpage                        % 节页
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

\begin{frame}[fragile]          % 注意添加 fragile 标记
  \frametitle{代码块}
  % 代码块参数：语言，标题
  % 请减少代码初始的缩进
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
  \printbibliography[heading=none]
\end{frame}

\makebottom       % 创建结束页

\end{document}
```

</details>

## 使用方法 🧰

普通用户只需编辑 `main.tex` 即可开始使用。

### 模版下载与编译

* Prism/TeXPage/Overleaf
  * 直接使用 [TeXPage 模板库链接](https://www.texpage.com/template/c0decdfd-ca66-4f4a-807d-5217f729dcfa)/[Overleaf 模板库链接](https://www.overleaf.com/latex/templates/sjtubeamer/dgvrnpndrtjh)。
  * 或者手动上传至 Prism/TeXPage/Overleaf 使用：
    * 下载开发版压缩包。页面右上角 Code - Download Zip 即可。
    * 或下载 [最新版](https://github.com/sjtug/SJTUBeamer/releases) 压缩包，点击 “Source Code (zip)” 即可下载。
    * 或下载 [最新版](https://github.com/sjtug/SJTUBeamer/releases) 最小依赖压缩包，点击 `sjtubeamer-online.zip` 下载。
    * 上传至 Prism/TeXPage/Overleaf。
    * TeXPage/Overleaf 的设置中需要选择“XeLaTeX”编译器编译；Prism 平台需要使用 `fontset=ubuntu` 字体选项。
* 本地使用
  * 安装 TeXLive 套件。
  * 下载模板至本地：
    * 使用 git 克隆仓库 `git clone https://github.com/sjtug/SJTUBeamer/` 或 `git clone https://mirror.sjtu.edu.cn/git/SJTUBeamer.git/`。
    * 或下载开发版压缩包。页面右上角 Code - Download Zip 即可。
    * 或下载 [最新版](https://github.com/sjtug/SJTUBeamer/releases) 压缩包。点击 “Source Code (zip)” 即可下载。
  * 之后通过 `latexmk -xelatex main.tex` 命令进行编译即可。
  * VSCode 用户可以使用 LaTeX Workshop 中的 “Recipe: latexmk (latexmkrc)” 进行编译。

目前模版最新的稳定版是 v3.2.0。您可以在 [发布页](https://github.com/sjtug/SJTUBeamer/releases) 查看修改日志和更多资料。通常来说，SJTUBeamer 的一个稳定版本包括如下内容：

* `sjtubeamerquickstart.pdf`：SJTUBeamer 快速入门，另见对应 [源代码](https://github.com/sjtug/SJTUBeamer/blob/main/src/doc/sjtubeamerquickstart.tex)。
* `sjtubeamer.pdf`: **强烈推荐在使用前阅读一遍 👍👍👍** SJTUBeamer 用户文档。
* `sjtubeamerdevguide.pdf`: SJTUBeamer 开发指南。
* `sjtulib-talk-max-red.pdf`: 示例文档《如何使用 LaTeX 排版论文》的 `max,red` 主题版本。
* `sjtulib-talk-maxplus-blue.pdf`: 示例文档《如何使用 LaTeX 排版论文》的 `maxplus,blue` 主题版本。
* `sjtulib-talk-maxplus-red.pdf`: 示例文档《如何使用 LaTeX 排版论文》的 `maxplus,red` 主题版本。
* `sjtulib-talk-min-red.pdf`: 示例文档《如何使用 LaTeX 排版论文》的 `min,red` 主题版本。
* `sample-all-covers.pdf`: 所有配色主题的封面封底。
* `sjtubeamer-ctan.zip`: 包含所有文档和样式的压缩包。
* `sjtubeamer-online.zip`：包含插件与最小依赖，适合于在线平台使用。
* SJTUBeamer 源代码。

请使用 Chrome 浏览器或 Adobe Acrobat 打开 SJTUBeamer 用户文档，以避免 PDF 兼容性导致的显示问题。

## 使用反馈与贡献代码 👷

* 文件清单详见 [MANIFEST](src/MANIFEST.md)。
* 在使用过程中，您可以在 [GitHub Discussions](https://github.com/sjtug/SJTUBeamer/discussions) 讨论区提问任何使用上的问题、交流想法。
* 在开发过程中，您可以通过 [GitHub Issues](https://github.com/sjtug/SJTUBeamer/issues) 提供 SJTUBeamer 的 Bug 反馈和新功能提案。同时，也欢迎您直接提交 [Pull Request](https://github.com/sjtug/SJTUBeamer/pulls) 代码修改帮助我们改进。
* 所有对模版的修改应该在 `.dtx` 文件中进行，而后用 l3build 生成 sty 文件。
* 您可以阅读发布页面中的《SJTUBeamer 开发指南》`sjtubeamerdevguide.pdf` 了解模版的实现细节与编译方法。

整个开发流程如下：

* 修改 `.dtx` 文件。
* 运行 `make generate` 将生成的 sty 文件拷贝到根目录下。
* 更新 `main.tex`，运行 `make build` 查看模版修改后的效果。
* 更新开发文档，运行 `make build-dev` 编译所有开发文档，运行单元测试。
* （可选）运行 `make format-dev` 格式化所有文件。
* 发 PR。

新贡献者可以将自己的信息加入 `src/doc/sjtubeamerdevguide.tex` 的 `Developer` 章节。

## 展示 🧐

详细展示见 [样式一览](https://github.com/sjtug/SJTUBeamer/discussions/138)。

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/61653082/160813366-5c7bd98b-dc3c-43ac-9cf4-1cb375228470.jpg">
  <img alt="Red Cover" src="https://user-images.githubusercontent.com/61653082/160813386-8cb98131-0cae-456b-af1e-cec671e5fc8e.jpg">
</picture>
    
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/61653082/160813414-9b43c4b3-4e6d-4f51-9c63-ff7a87eafcf7.jpg">
  <img alt="Blue Cover" src="https://user-images.githubusercontent.com/61653082/160813430-1c7647d4-6346-4fd8-b43f-e156b6234b0e.jpg">
</picture>

## 许可证

SJTUBeamer 仓库同时包含 SJTUBeamer 包和一个示例文档。其中内容的许可证各不相同。您可以阅读各个文件的开头部分，了解该文件所使用的许可证。

* SJTUBeamer 包使用的许可证为 Apache-2.0。
* SJTUBeamer 示例文档使用 CC-BY-SA 4.0 许可。
* sjtuvi 和 sjtucover 库及其附属徽标、图片由上海交通大学持有版权。校属各单位及个人以经营为目的使用视觉形象识别系统，须向学校申请使用许可。校外单位及个人未经许可，不得制作或使用载有视觉形象识别系统的物品。您可以在 [vi.sjtu.edu.cn](https://vi.sjtu.edu.cn/index.php/articles/bulletin/16) 阅读许可协议。
