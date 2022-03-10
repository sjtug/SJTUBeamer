# 向 SJTUBeamer 贡献插件

SJTUBeamer 现在已经开放插件接口，存放于根目录的 `contrib/` 文件夹中。如果您实现了自己的主题模板，或者是基于 SJTUBeamer API 的宏包，可以考虑通过下面的步骤向本存储库发 PR：
1. fork 仓库，克隆自己的仓库到本地。
2. 向你的电脑安装当前版本的 SJTUBeamer，`cd src && l3build install`，在 TeX 发布版中刷新文件名数据库，便于插件文档的编写。
3. 在 `contrib` 文件夹中新建一个插件文件夹 `<theme>`
4. 在文件夹中至少应该有下面两个文件：
    - 插件入口 `contrib/<theme>/sjtubeamertheme<theme>.ltx`
    - 插件文档 `contrib/<theme>/<theme>.tex`
5. 如果在插件中需要使用相对于该插件目录的文件，请使用下面的 API：
    - `\getcontribdir{<theme>}` 返回插件目录 `contrib/<theme>`
    - `\getcontribpath{<theme>}{<filepath>}` 返回插件文件 `contrib/<theme>/<filepath>`
6. 发 PR 时，使用 `contrib: <theme>` 作为标题，并向维护者发出代码审查请求。
7. 之后在根目录的主文件中就可以在 `\usetheme[my]{sjtubeamer}` 后使用 `\usemytheme{<theme>}` 调用你的插件。

更多信息，请参阅开发文档。

-----

# Contribute to SJTUBeamer

SJTUBeamer is available for receiving plugins, which are stored in `contrib/` folder. If you want to contribute your own theme template or package based on SJTUBeamer API, you could make a pull request to this repo by the following steps:
1. Fork this repository and clone your own version to the machine.
2. Install the current version of `SJTUBeamer` to your computer for the convenience of writing documentation.
`cd src && l3build install`, then refresh the database of filenames in your TeX distribution.
3. Create a new plugin folder `<theme>` in `contrib`.
4. At least two files should be implemented in the folder:
    - Plugin entry point. `contrib/<theme>/sjtubeamertheme<theme>.ltx`
    - Plugin documentation. `contrib/<theme>/<theme>.tex`
5. If you want to use the file in your plugin directory, use the following API:
    - `\getcontribdir{<theme>}` returns the plugin directory `contrib/<theme>`
    - `\getcontribpath{<theme>}{<filepath>}` returns plugin file path `contrib/<theme>/<filepath>`
6. Pull request to this repo naming `contrib: <theme>`, request a review from one of the collaborators.
7. Now, you could call your plugin by using `\usemytheme{<theme>}` after `\usetheme[my]{sjtubeamer}`.

For more information, please refer to the development guide.