#!/usr/bin/env texlua

module           = "sjtubeamer"

sourcefiledir    = "source"
sourcefiles      = {"*.ins","*.dtx","vi/"}
installfiles     = {"*.sty","vi/"}

maindir          = "."
docfiledir       = maindir .. "/doc"
supportdir       = maindir .. "/support"

builddir         = maindir .. "/build"
typesetdir       = builddir .. "/doc"

if os.type == "windows" then
    typesetexe       = "pdflatex"
    etypesetexe      = "etex"
else
    typesetexe       = "xelatex"
    etypesetexe      = "xetex"
end

typesetopts      = "-interaction=nonstopmode -shell-escape"
typesetfiles     = {"sjtubeamer.tex","sjtubeamerdevguide.tex","sjtubeamerquickstart.tex"}
typesetsuppfiles = {"sjtug.pdf","sjtug_text.pdf","tutorial/"}

-- Regression tests mainly test the decoupling properties between kernel modules.
testfiledir      = "./testfiles"

packtdszip       = true -- recommended for "tree" layouts

tagfiles = {"*.dtx","*.ins","sjtubeamer*.tex"}

-- Related to `l3build tag`
-- Detail how to set the version automatically
function update_tag(file,content,tagname,tagdate)
    local iso = "%d%d%d%d%/%d%d%/%d%d"
    if string.match(content,"%(C%)%s*[%d%-,]+") then
        local year = os.date("%Y")
        content = string.gsub(content,
            "%(C%)%s*([%d%-,]+)",
            "(C) %1," .. year)
        content = string.gsub(content,year .. "," .. year,year)
        content = string.gsub(content,
        "%-" .. math.tointeger(year - 1) .. "," .. year,
        "-" .. year)
        content = string.gsub(content,
        math.tointeger(year - 2) .. "," .. math.tointeger(year - 1) .. "," .. year,
        math.tointeger(year - 2) .. "-" .. year)
    end
    local now = os.date("%Y/%m/%d")
    content = string.gsub(content,
        "\\Provides" .. "([^%[]+)%[" .. iso .. " v%d+%.%d+%.%d+ ([^%]]+)]",
        "\\Provides%1[" .. now .. " " .. tagname .. " %2]")
    return content
end

-- Compiling file in a certain receipe: tex -> biber(-) -> tex(+)
-- by assigning different symbols in the filename.
-- This will patch l3build compilation "tex" command.
function compile_file(dir, cmd, filename)
    local errorlevel = 0
    errorlevel = run(dir, cmd .. " " .. filename)
    if string.find(filename,"+") ~= nil then
        if string.find(filename,"_") ~= nil then
            errorlevel = bibtex(string.gsub(filename,".tex",""),dir)
            errorlevel = run(dir,cmd .. " " .. filename)
        end
        if string.find(filename,"-") ~= nil then
            -- biber after compiling the first time if it is marked as "-"
            errorlevel = biber(string.gsub(filename,".tex",""),dir)
            errorlevel = run(dir,cmd .. " " .. filename)
        end
        -- compile the second time if it is marked as "+"
        errorlevel = run(dir,cmd .. " " .. filename)
    end
    return errorlevel
end

-- Related to `l3build doc`
-- Generate tutorial files before compiling the doc.
function typeset_demo_tasks()
    local errorlevel = 0
    local tutorialdir = typesetdir .. "/tutorial"

    print("============================================================")
    print("If you want to save the previous demo files")
    print("Use \"l3build cache-demo\" command (" .. module .. ")")
    print("============================================================")
    
    print("Compiling precompiled header...")
    local cacheable = true
    local headerfilename = "commonheader"
    local etypesetcommand = etypesetexe .. "  -ini -interaction=nonstopmode -jobname=" .. headerfilename .. " \"&" .. typesetexe .. "\" mylatexformat.ltx "
    errorlevel = tex("\"\"\"" .. headerfilename .. ".tex\"\"\"", tutorialdir, etypesetcommand)
    if errorlevel ~= 0 then
        print("common header compilation failed.")
        cacheable = false
    end

    -- Move generated files to the tutorial directory
    -- Since mylatexformat doesn't support relative directory well.
    for _,file in pairs(installfiles) do
        cp(file, unpackdir, tutorialdir)
    end
    local typesetcommand = typesetexe .. " " .. typesetopts   -- patch l3build
    for _, p in ipairs(filelist(tutorialdir, "step*.tex")) do
        local pdffilename = string.gsub(p,".tex",".pdf")
        if p == "step0.tex" then
            errorlevel = run(tutorialdir,typesetcommand .. " " .. p)
            if errorlevel ~= 0 then
                print("unable to cache, fallback to standard compilation.")
                cacheable = false       -- compile on test caching file failed.
            end
        else
            if fileexists(tutorialdir .. "/" .. pdffilename) == false then
                local stepfile = io.open(tutorialdir .. "/" .. p, "r")
                if cacheable and string.match(stepfile:read("l"),"\\documentclass{ctexbeamer}") ~= nil then
                    -- use the precompiled header to compile.
                    local cachedfilename = "tmp" .. p
                    local cachedfile = io.open(tutorialdir .. "/" .. cachedfilename, "w")
                    cachedfile:write("%&commonheader\n\\endofdump\n\\usepackage{ctex}\n")
                    for line in stepfile:lines("L") do
                        cachedfile:write(line)
                    end
                    cachedfile:close()
                    stepfile:close()

                    errorlevel = compile_file(tutorialdir, typesetcommand, cachedfilename)
                    if errorlevel ~= 0 then
                        print("!" .. pdffilename .. " compilation failed.")
                        return errorlevel
                    end
                    errorlevel = ren(tutorialdir, "tmp" .. pdffilename, pdffilename)
                else
                    -- fallback to standard compilation.
                    errorlevel = compile_file(tutorialdir, typesetcommand, p)
                    if errorlevel ~= 0 then
                        print("! " .. pdffilename .. " compilation failed.")
                        return errorlevel
                    end
                end
            else
                print("Reuse: " .. pdffilename)
            end
        end
    end
    return 0
end

snippetdir = "../.vscode"
snippetfilename = "sjtubeamer.code-snippets"

-- Generate Visual Studio Code snippets
-- To make it run properly, please follow the Coding Style guideline.
-- TODO: This could be replaced by Language Server Protocol (LSP) in the future in order to support mainstream IDEs. And will be implemented as a form of extension.
function gen_snippets()
    if not direxists(snippetdir) then
        mkdir(snippetdir)
    end
    snippetfile = io.open(snippetdir .. "/" .. snippetfilename, "w")
    snippetfile:write("{\n")
    dtx_filelist = filelist(sourcefiledir, "*.dtx")
    table.sort(dtx_filelist)        -- sort to avoid difference
    for _, p in ipairs(dtx_filelist) do
        local in_macro = nil
        local macro_body = ""
        local macro_desc = ""
        local in_code = false
        local captured = 0
        for line in io.lines(sourcefiledir .. "/" .. p) do
            if in_macro ~= nil and captured == 0 then
                -- Find TeX style definition, see Coding Style 3.1.2
                local def_param = string.match(line, "\\def" .. in_macro .. "([#%d]*)")
                -- Find LaTeX style definition, see Coding Style 3.1.3
                local comm_decl, comm_param, param_default = string.match(line, "\\(%a+<?>?%*?){" .. in_macro .. "}%[?(%d?)%]?(%[?%a*@*\\*%]?)")
                if def_param ~= nil then
                    def_param = string.gsub(def_param, "#(%d)", "{$%1}")
                    macro_body = macro_body .. "\\" .. in_macro .. def_param
                    captured = 1
                elseif comm_decl ~= nil and (string.find(comm_decl, "new") ~= nil or string.find(comm_decl, "provide") ~= nil) then
                    comm_param = tonumber(comm_param) or 0
                    if string.sub(in_macro,1,1) == "\\" then
                        macro_body = macro_body .. "\\" .. in_macro
                        captured = 2
                    else -- an environment
                        macro_body = macro_body .. "\\n\\\\begin{" .. in_macro .. "}"
                        captured = 3
                    end
                    if string.find(comm_decl, "<>") ~= nil then
                        -- Command has an overlay option.
                        macro_body = macro_body .. "<$" .. comm_param + 1 .. ">"
                    end
                    if comm_param > 0 then
                        -- Command has parameters.
                        if param_default ~= "" then
                            -- Command has a default parameter.
                            param_default = string.gsub(string.sub(param_default, 2, -2),"\\","\\\\") -- remove square brackets
                            macro_body = macro_body .. "[${1:" .. param_default .. "}]"
                        else
                            -- No default parameter is specified.
                            macro_body = macro_body .. "{$1}"
                        end
                        for i=2,comm_param do
                            macro_body = macro_body .. "{$" .. i  .."}"
                        end
                    end
                    if captured == 3 then   -- close the environment
                        macro_body = macro_body .. "\\n\\t$" .. comm_param + 1 .. "\\n\\\\end{" .. in_macro .. "}\\n"
                    elseif string.find(comm_decl, "command") == nil and string.find(comm_decl, "input") == nil then
                        -- it is a definition method from 3rd party package, which often requires an applying region.
                        -- except for \newtcbinputlisting
                        macro_body = macro_body .. "{$" .. comm_param + 1 .. "}"
                    end
                -- Find begin macrocode environment, see Coding Style 3.3.2
                elseif line == "%    \\begin{macrocode}" then
                    in_code = true
                -- Won't find end macrocode environment, only capture the first part of this macro as description.
                elseif in_code == false then
                    -- Now it is just a plain description of this macro.
                    macro_desc = macro_desc ..
                    string.gsub(string.gsub(string.gsub(string.gsub(string.sub(line,2),"\\verb\"([^\"]+)\"","%1"),"\\","\\\\"),"\"","\\\""),"%s%+","") .. "\\n"
                end
            end

            -- Find begin macro DocTeX environment, see Coding Style 3.3.1
            local env_beg = string.match(line, "\\begin{macro}{(\\*[%a@]+)}")
            if env_beg ~= nil then
                in_macro = env_beg
            end
            -- Find end macro DocTeX environment, see Coding Style 3.3.1
            if string.match(line, "\\end{macro}") ~= nil and in_macro ~= nil then
                -- This macro is processed complete.
                local match_comm = string.gsub(in_macro, "\\", "\\\\")
                if captured == 3 then
                    match_comm = "\\n\\\\begin{" .. match_comm
                end
                local scope = "doctex,tex"
                if (captured >= 2 or macro_body == "") and
                    string.find(in_macro,"@") == nil then
                    scope = scope .. ",latex"   -- public use
                end
                if macro_body == "" then
                    macro_body = match_comm     -- no abvious definition
                    if string.sub(in_macro,1,1) == "\\" and     -- a macro
                        string.find(in_macro,"@") == nil then   -- not an internal variable, see Coding Style 3.1.4
                        macro_body = macro_body .. "{$1}"       -- it is more like an interface
                    end
                end
                snippetfile:write("\t\"" .. string.gsub(in_macro,"\\","") .. "\": {\n")
                snippetfile:write("\t\t\"scope\": \"" .. scope .. "\",\n")
                snippetfile:write("\t\t\"prefix\": \"" .. match_comm .. "\",\n")
                snippetfile:write("\t\t\"body\": \"" .. macro_body .. "\",\n")
                snippetfile:write("\t\t\"description\": \"" .. macro_desc .. "\"\n")
                snippetfile:write("\t},\n")
                in_macro = nil
                in_code = false
                captured = 0
                macro_body = ""
                macro_desc = ""
            end
        end
    end
    snippetfile:write("}")
    snippetfile:close()
end

-- Related to `l3build check`
function checkinit_hook()
    gen_snippets()

    -- Move generated files to the main directory when it starts to check.
    for _,src in pairs(installfiles) do
        -- patch l3build copying action on directories.
        if string.sub(src,-1,-1) == "/" then
            local targetdir = "../" .. src
            if not direxists(targetdir) then
                mkdir(targetdir)
            end
            cp("*", unpackdir .. "/" .. src, targetdir)
        else
            cp(src, unpackdir, "../")
        end
    end

    return 0
end

-- Related to `l3build manifest`
-- FIXME: subfolders could not be detected. Use plain text for temporary fix.
manifest_setup = function ()
local groups = {
    {
        subheading = "Minimal manifest",
        description = [[
The following group lists all the necessary files that required by the runtime.
You could install these files to your TeX distribution or distribute them with
your main document.]]
    },
    {
        name    = "Minimal workset",
        description = "* vi/",
        dir     = tdsdir.."/tex/"..moduledir,
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
    {
        subheading = "Repository manifest",
        description = [[
The following groups list the files included in the development repository of the package.
Files listed with a ‘†’ marker are included in the TDS but not CTAN files, and files listed
with ‘‡’ are included in both.
]],
    },
    {
        name    = "Source files",
        description = [[
These are source files for a number of purposes, including the `unpack` process which
generates the installation files of the package. Additional files included here will also
be installed for processing such as testing.
]],
        files   = {sourcefiles},
        dir     = sourcefiledir,
    },
    {
        name    = "Typeset documentation source files",
        description = [[
These files are typeset using LaTeX to produce the PDF documentation for the package.
]],
        files   = {typesetfiles},
        dir     = docfiledir,
    },
    {
        name    = "Derived files",
        description = [[
**Installation (1/2)** The files created by ‘unpacking’ the package sources. This typically includes
`.sty` and `.cls` files created from DocStrip `.dtx` files.
]],
        files   = {installfiles},
        exclude = {excludefiles,sourcefiles},
        dir     = unpackdir,
        skipfiledescription = true,
    },
    {
        name   = "Graphics resources",
        description = [[
**Installation (2/2)** These files are in `vi/` directory ‡. To provide the basic
graphics resources for creating presentations.
]],
        files  = {"*.*"},
        dir    = sourcefiledir .. "/vi",
        exclude = {{".",".."},excludefiles},
        skipfiledescription = true,
    },
    {
        name    = "Typeset documents",
        description = [[
The output files (PDF, essentially) from typesetting the various source, demo,
etc., package files.
]],
        files   = {typesetfiles},
        dir     = docfiledir,
        rename  = {"%.%w+$", ".pdf"},
        skipfiledescription = true,
    },
    {
        name    = "Test files",
        description = [[
**Regression Tests**
These files form the test suite for the package. `.lvt` or `.lte` files are the individual
unit tests, and `.tlg` are the stored output for ensuring changes to the package produce
the same output. These output files are sometimes shared and sometime specific for
different engines (pdfTeX, XeTeX, LuaTeX, etc.).
]],
        files   = {"*"..lvtext,"*"..lveext,"*"..tlgext},
        dir     = testfiledir,
        skipfiledescription = true,
    },
    {
        name    = "Tutorial files",
        description = [[
**Unit Tests**
Files included to demonstrate package functionality. And they are also the demo files for the user guide.
These files will be typesetted first before typesetting the documentation source files.
They could be cached in the next round by `l3build cache-demo`.
The cache could be cleaned by `l3build clean-demo`.
To add a demo file, use `l3build add-demo 20`.
]],
        files   = {"step*.tex"},
        dir     = supportdir .. "/tutorial",
        skipfiledescription = true,
    },
    {
        subheading = "TDS manifest",
        description = [[
The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.
]],
    },
    {
        name    = "Source files (TDS)",
        description = "All files included in the `"..module.."/source` directory.\n",
        dir     = tdsdir.."/source/"..moduledir,
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
    {
        name    = "TeX files (TDS)",
        description = "All files included in the `"..module.."/tex` directory." ..
        " This directory contains all the files in the **Minimal workset**."
        .. "\n\n"
        .. "* vi/",
        dir     = tdsdir.."/tex/"..moduledir,
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
    {
        name    = "Doc files (TDS)",
        description = "All files included in the `"..module.."/doc` directory.\n",
        dir     = tdsdir.."/doc/"..moduledir,
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
    {
        subheading = "CTAN manifest",
        description = [[
The following group lists the files included in the CTAN package.
]],
    },
    {
        name    = "CTAN files",
        description = "* vi/",
        dir     = ctandir.."/"..module,
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
    {
        subheading = "Online manifest",
        description = [[
The following group lists the files included in the online distribution.
You could upload the package to any online plateforms. Compared with
**Minimal workset**, this distribution comes with all the plugins and
quick start guide as the main file.
You could generate the package by going to the root directory and
using the command `make build-online` in the terminal.
]],
    },
    {
        name    = "Online files",
        description = [[
* contrib/
* build/
* vi/]],
        dir     = "../build/online",
        files   = {"*.*"},
        exclude = {".",".."},
        flag    = false,
        skipfiledescription = true,
    },
}
return groups
end

manifest_extract_filedesc = function(filehandle)

    local all_file = filehandle:read("*all")
    local matchstr = "\\Provides[^%[]+%[%d%d%d%d/%d%d/%d%d v%d+%.%d+%.%d+ ([^%]]+)%]"
  
    filedesc = string.match(all_file,matchstr)
  
    return filedesc
end

----------------------
-- Exclusive Commands
----------------------

-- usage: l3build cache-demo
-- description: cache the demo pdf files after l3build doc.
if options["target"] == "cache-demo" then
    print("Use this command after l3build doc.")
    print("Use l3build clean-demo to clean the cache. (" .. module ..")")

    local function cachedemo()
        local tutorialdir = typesetdir .. "/tutorial"
        local targetdir = supportdir .. "/tutorial"
        print("Demo files in " .. tutorialdir .. " will be cached to " .. targetdir)
        local cachedcnt = 0
        local totalcnt = 0
        -- Cache the pdf corresponding to the tex file
        for _, p in ipairs(filelist(tutorialdir, "step*.tex")) do
            local pdffilename = string.gsub(p,".tex",".pdf")
            totalcnt = totalcnt + 1
            if fileexists(tutorialdir .. "/" .. pdffilename) then
                -- Move the pdf to the support dir
                cp(pdffilename, tutorialdir, targetdir)
                print("Cached: " .. pdffilename)
                cachedcnt = cachedcnt + 1
            else
                print("NO: " .. pdffilename)
            end
        end
        print("Cached/Total: " .. cachedcnt .. "/" .. totalcnt)
    end

    cachedemo()
    os.exit(0)
end

-- usage: l3build clean-demo
-- description: clean the cached demo pdf files from l3build cache-demo.
if options["target"] == "clean-demo" then

    local function cleandemo()
        local tutorialdir = typesetdir .. "/tutorial"
        print("Clean the cached demo in " .. tutorialdir .. ". (" .. module .. ")")
        local cleancnt = 0
        for _, p in ipairs(filelist(tutorialdir, "step*.pdf")) do
            -- Remove the pdf in the build dir and the support dir.
            rm(tutorialdir, p)
            rm(supportdir .. "/tutorial", p)
            cleancnt = cleancnt + 1
            print("Clean: " .. p)
        end
        print("Clean: " .. cleancnt)
    end

    cleandemo()
    os.exit(0)
end

-- usage: l3build add-demo [demonum]
-- description: add step[demonum].tex to the tutorial directory.
if options["target"] == "add-demo" then
    if options["names"] == nil or #options["names"] > 1 then
        print("Error: Please specify one and only one demo number. (" .. module .. ")")
        os.exit(1)
    end

    -- The added demo number.
    local demonum = tonumber(options["names"][1])
    if demonum == nil then
        print("Error: \"" .. options["names"][1] .. "\" is not a valid number.")
        os.exit(1)
    end

    local function adddemo(demonum)
        local tutorialsuppdir = supportdir .. "/tutorial"
        print("Add step" .. options["names"][1] .. ".tex to " .. tutorialsuppdir .. ". (" .. module .. ")")

        -- Record the demo number which is not less than the added number
        local actionlist = {}
        local renflag = false
        for _, p in ipairs(filelist(tutorialsuppdir, "step*.tex")) do
            local curdemoid = string.sub(p, 5, -5)
            local curdemonum = tonumber(string.gmatch(curdemoid, "%d+")())
            if curdemonum ~= nil then   -- exclude something like "stepalgo.tex"
                if curdemonum >= demonum then
                    table.insert(actionlist, {curdemonum, curdemoid})
                end
                if curdemonum == demonum then
                    renflag = true
                end
            end
        end

        -- If the target added demo file exists,
        -- The demo with larger demo number will be renamed in a descending order. Like a "refactor" action.
        if renflag then
            table.sort(actionlist, function(i,j)
                if i[1] > j[1] then
                    return true
                end
                if i[1] == j[1] then
                   return #i[2] > #j[2] -- the longer one should be first replaced.
                end
                return false
            end)

            -- read sjtubeamer.tex
            local usrdoc = docfiledir .. "/sjtubeamer.tex"
            local usrdocfile = io.open(usrdoc, 'r')
            local usrdoccontent = usrdocfile:read("a")
            usrdocfile:close()

            for _, num in ipairs(actionlist) do
                local oldid = num[2]
                local num = num[1]
                local oldcachepdf = "step" .. oldid .. ".pdf"
                if fileexists(tutorialsuppdir .. "/" .. oldcachepdf) then
                    rm(tutorialsuppdir, oldcachepdf)
                    print(oldcachepdf .. " cache is deleted.")
                end
                local newid = string.gsub(oldid, num, num + 1)
                ren(tutorialsuppdir, "step" .. oldid .. ".tex", "step" .. newid .. ".tex")
                
                -- modify the number in usr doc content.
                local cnt
                usrdoccontent, cnt = string.gsub(usrdoccontent, "step" .. 
                string.gsub(string.gsub(oldid,"%+","%%+"),"%-","%%-") .. 
                "%.", "step" .. newid .. ".") -- avoid the magical character insertion

                print("step" .. oldid .. " -> " .. "step" .. newid .. " Doc replaced: " .. cnt)
            end

            -- write sjtubeamer.tex
            local usrdocfile = io.open(usrdoc, "w+")
            usrdocfile:write(usrdoccontent)
            usrdocfile:close()
        end

        -- The new demo file will be created.
        local newdemofilename = "step" .. demonum .. ".tex"
        cp("step.template.tex", supportdir, tutorialsuppdir)
        ren(tutorialsuppdir, "step.template.tex", newdemofilename)
        print("Create: " .. tutorialsuppdir .. "/" .. newdemofilename .. ", Edit your new demo there.")
        print("You could rename the demo file for different compilation processes:")
        print("  +: add 1 more (xe)latex compilation;\n  -: add 1 more biber;\n  _: add 1 more bibtex")

    end

    adddemo(demonum)
    os.exit(0)
end

-- contrib directory
contribdir = "../contrib"

-- usage: l3build add-contrib [pluginname]
-- description: initialize a plugin called [pluginname].
if options["target"] == "add-contrib" then
    if options["names"] == nil or #options["names"] > 1 then
        print("Error: Please specify one and only one contrib name. (" .. module .. ")")
        os.exit(1)
    end

    local pluginname = options["names"][1]

    local function addcontrib(pluginname)
        local plugindir = contribdir .. "/" .. pluginname
        if not direxists(plugindir) then
            -- make plugin directory
            mkdir(plugindir)

            -- generate plugin itself
            cp("sjtubeamerthemenewcontrib.template.ltx", supportdir, plugindir)
            ren(plugindir, "sjtubeamerthemenewcontrib.template.ltx", "sjtubeamertheme" .. pluginname .. ".ltx")
            local pluginpath = plugindir .. "/" .. "sjtubeamertheme" .. pluginname .. ".ltx"
            local pluginfile = io.open(pluginpath, 'r')
            local pluginfilecontent = pluginfile:read('a')
            pluginfile:close()
            pluginfilecontent = string.gsub(
                string.gsub(
                    string.gsub(pluginfilecontent, "<year>", os.date("%Y")),
                        "0000/00/00",os.date("%Y/%m/%d")),
                            "newcontrib", pluginname
                )
            -- get information from git
            -- no swap when no git
            print('Trying to get author and email information from:')
            local errorlevel = os.execute("git --version")
            if errorlevel == 0 then
                local author = io.popen("git config --get user.name",'r')  -- get author info
                if author ~= nil then
                    pluginfilecontent = string.gsub(pluginfilecontent, '<author>', author:read('*l'))
                end
                author:close()
                local email = io.popen("git config --get user.email",'r') -- get author email
                if email ~= nil then
                    pluginfilecontent = string.gsub(pluginfilecontent, '<email>', '<' .. email:read('*l') .. '>')
                end
                email:close()
            end
            pluginfile = io.open(pluginpath, 'w')
            pluginfile:write(pluginfilecontent)
            pluginfile:close()

            -- generate plugin documentation
            cp("newcontrib.template.tex", supportdir, plugindir)
            ren(plugindir, "newcontrib.template.tex", pluginname .. ".tex")
            local plugindocpath = plugindir .. "/" .. pluginname .. ".tex"
            local plugindocfile = io.open(plugindocpath, 'r')
            local plugindoccontent = plugindocfile:read('a')
            plugindocfile:close()
            plugindoccontent = string.gsub(plugindoccontent, "newcontrib", pluginname)
            plugindocfile = io.open(plugindocpath, 'w')
            plugindocfile:write(plugindoccontent)
            plugindocfile:close()

            print(pluginname .. " plugin is created.")
            print("  > Plugin itself: " .. pluginpath)
            print("  > Plugin documentation: " ..plugindocpath)
            print("To debug the plugin, install the current version of sjtubeamer globally first by:")
            print("  l3build install")
            print("Then compile the documentation in the contrib directory: " .. plugindir)
        else
            print("Error: " .. pluginname .. " has already existed.")
            os.exit(1)
        end
    end

    addcontrib(pluginname)
    os.exit(0)
end
