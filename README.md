# sjtubeamermin

[![.github/workflows/build.yml](https://github.com/LogCreative/SJTUBeamermin/actions/workflows/build.yml/badge.svg)](https://github.com/LogCreative/SJTUBeamermin/actions/workflows/build.yml) [![Overleaf](https://img.shields.io/badge/Overleaf-v0.9--LTS-green)](https://www.overleaf.com/latex/templates/sjtubeamermin/shxnnnjjgqvp)

## 上海交通大学 LaTeX Beamer 幻灯片模板 - VI 最小工作集

sjtubeamermin 样式为上海交通大学幻灯片模板的 LaTeX 非官方实现版本，是符合[上海交通大学视觉形象识别系统](http://vi.sjtu.edu.cn/)相关规范的最小工作集，图标版权归上海交通大学所有，本项目仅供校内人员学习参考使用。

[SJTUBeamermin 样式文档](doc/sjtubeamermintheme.pdf)

[向该项目贡献代码](doc/sjtubeamermindevguide.pdf)

## 快速上手

[使用该模板](https://github.com/LogCreative/SJTUBeamermin/generate) 后，修改 `doc/my.tex` 的相关内容，提交后将会在 GitHub Actions 页面的运行记录里看到生成的文件。

## 局部安装

可以在 发布页 得到对应的发布包，使用发布包内的 `sty` 文件以及 `pdf` logo 文件附着于本地文件夹内即可使用。

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

> Copyright (C) 2021 Log Creative
>
> The copyright holder for the logo is SJTU. The template itself doesn't change the ownership of the related graphics in the guideline. 
SJTU logo and related pattern are only available for non-commercial purposes.
> 
> This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
