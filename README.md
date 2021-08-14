# sjtubeamermin

[![.github/workflows/build.yml](https://github.com/LogCreative/SJTUBeamermin/actions/workflows/build.yml/badge.svg)](https://github.com/LogCreative/SJTUBeamermin/actions/workflows/build.yml) [![Overleaf](https://img.shields.io/badge/Overleaf-v0.9--LTS-green)](https://www.overleaf.com/latex/templates/sjtubeamermin/shxnnnjjgqvp)

## 上海交通大学 LaTeX Beamer 幻灯片模板 - VI 最小工作集

sjtubeamermin 样式为上海交通大学幻灯片模板的 LaTeX 非官方实现版本，是符合[上海交通大学视觉形象识别系统](http://vi.sjtu.edu.cn/)相关规范的最小工作集，图标版权归上海交通大学所有，本项目仅供校内人员学习参考使用。

[SJTUBeamermin 样式文档](doc/sjtubeamermintheme.pdf)

[向该项目贡献代码](doc/sjtubeamermindevguide.pdf)

## 快速上手

[使用该模板](https://github.com/LogCreative/SJTUBeamermin/generate) 后，修改 `doc/my.tex` 的相关内容，提交后将会在 GitHub Actions 页面的运行记录里看到生成的文件。

## 局部安装

可以在 [发布页](https://github.com/LogCreative/SJTUBeamermin/releases) 得到对应的发布包，使用发布包内的 `sty` 文件以及 `pdf` logo 文件附着于本地文件夹内即可使用。

## 构建

本项目采用 `l3build` 构建。本地安装方法：
```
l3build ctan
l3build install
```

该方法若不奏效，可以采用老版解包方法：
```
cd source
latex beamerthemesjtubeamermin.ins
```
按照提示将输出文件放置在需要调用的文件同一目录下。

## 示例

详见 [示例文件](doc/red.tex) 。

> (C) 2021 Log Creative
>
> 图标归 [上海交通大学](vi.sjtu.edu.cn) 所有，本模板不持有该版权。根据规定，任何校外人员用于商业用途均需要向学校申请。
> 任何不当使用，Log Creative 免于相关责任。
> 
> 本作品遵守 [LPPL-1.3c](LICENSE) 协议。

-----

## Shanghai Jiao Tong University LaTeX Beamer Template - VI Minimal Workset (Unofficial)

`sjtubeamermin` theme is an unofficial implementation of SJTU UI, as a beamer theme for making presentation. SJTU logo and its related graphics are owned by SJTU, which requires the permission from SJTU administration for any commercial purposes.

[Documentation (Chinese)](doc/sjtubeamermintheme.pdf)

[Developer's Guide](doc/sjtubeamermindevguide.pdf)

## Quick Run

After [Use this template](https://github.com/LogCreative/SJTUBeamermin/generate), modify `doc/my.tex`. You could see the produced document from GitHub Actions page.

## Local Installation

You could get the release package on the [release page](https://github.com/LogCreative/SJTUBeamermin/releases). Use the `.sty` files and `sjtucnlogo.pdf` and `sjtuenlogo.pdf` for your template.

## Build

Local build through `l3build`:
```
l3build ctan
l3build install
```

If it doesn't work, you could use the old method：
```
cd source
latex beamerthemesjtubeamermin.ins
```
Copy the generated file to the required place.

## Example

See [example code](doc/red.tex) for details.

> Copyright (C) 2021 Log Creative
>
> The copyright holder for the logo is SJTU. The template itself doesn't change the ownership of the related graphics in the guideline. 
SJTU logo and related pattern are only available for non-commercial purposes.
> 
> This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
