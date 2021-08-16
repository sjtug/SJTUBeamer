# SJTUBeamer 🤓

欢迎使用 SJTUBeamer! 🥳

SJTUBeamer 是上海交通大学的非官方 Beamer 模版。您可以使用 SJTUBeamer 制作幻灯片，展示您的成果。

> **合并中的开发分支** 本分支正在与 SJTUBeamermin 合并。需要修改源代码，进入 `src/source` 对应文件修改，然后在根目录
```
.github/ci/build_package.sh
```
什么，你用的 Windows？直接去 Actions 选单中取 package 作为预编译出来的文件依赖。

## 使用方法 🧰

Overleaf 用户可以直接下载 [最新版](https://github.com/sjtug/SJTUBeamer/archive/refs/heads/main.zip) 或 
[v1.0.0](https://github.com/sjtug/SJTUBeamer/releases/tag/v1.0.0) 的代码，上传至 Overleaf 使用。

如果您希望在本地使用 SJTUBeamer 模版，请安装 TeXLive 套件，并通过 `latexmk -xelatex main.tex` 命令进行编译。
VSCode 用户可以使用 LaTeX Workshop 中的“Recipe: latexmk (latexmkrc)”进行编译。

## 设计哲学 💭

简单易用，即使是 LaTeX 初学者也能轻松上手。

## 使用反馈与贡献代码 👷

您可以通过 GitHub Issue 反馈使用时碰到的问题。同时，也欢迎您提交 PR 帮助我们改进。

## 展示 🧐

您可以在 [v1.0.0](https://github.com/sjtug/SJTUBeamer/releases/tag/v1.0.0) 预览生成的四个主题的 pdf。

**蓝色主题封面**

![page001](https://user-images.githubusercontent.com/4198311/119085675-be619a80-ba36-11eb-878f-609b2882dc35.png)

**红色主题封面**

![page001](https://user-images.githubusercontent.com/4198311/119085697-c7526c00-ba36-11eb-8a70-296f8f36c2d6.png)

**普通封面**

![page001](https://user-images.githubusercontent.com/4198311/118810621-aa0a8a00-b8de-11eb-907e-6342c156ea53.png)

**红色主题内页**

![page004](https://user-images.githubusercontent.com/4198311/118810609-a70f9980-b8de-11eb-84b3-68918c905817.png)
