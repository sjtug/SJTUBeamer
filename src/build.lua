#!/usr/bin/env texlua

module           = "sjtubeamer"

sourcefiledir    = "source"
sourcefiles      = {"*.ins","*.dtx","vi/","latexmkrc"}
installfiles     = {"*.sty","vi/","latexmkrc"}

docfiledir       = "doc"

if os.type == "windows" then
    typesetexe       = "pdflatex"
else
    typesetexe       = "xelatex"
end

typesetopts      = "-interaction=nonstopmode -shell-escape"
typesetfiles     = {"sjtubeamerdevguide.tex","sjtubeamer.tex"}
-- typesetfiles     = {"sjtubeamer.tex"}
-- typesetruns      = 1 -- for debug. Some reference may not be linked.
-- typesetdemofiles = {"min.tex"}
typesetsuppfiles = {"head.png","plant.jpg","test.csv","testgraph.tex","ref.bib","sjtug.pdf","sjtug_text.pdf","tutorial/"}

-- Regression tests mainly test the decoupling properties between kernel modules.
testfiledir      = "./testfiles"

packtdszip       = true -- recommended for "tree" layouts

tagfiles = {"*.dtx","README.md","*.ins","sjtubeamermintheme.tex","sjtubeamermindevguide.tex"}

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
    if string.match(file,"%.dtx$") then
        content = string.gsub(content,
            "\n\\ProvidesPackage" .. "({%w+})%[" .. iso .. "([^%]]+) v%d%.%d%.%d]",
            "\n\\ProvidesPackage%1[" .. now .. "%2 " .. tagname .. "]")
        return content
    elseif string.match(file,"%.tex$") then
        return string.gsub(content,
            "\n\\date%{%d%.%d ([^%}]+)%}\n",
            "\n\\date{" .. tagname .. " %1}\n")
    end
    return content
end

-- Generate tutorial files before compiling the doc.
-- NOTICE: if you want to save the tourial step pdf,
--         please enter support/tutorial and run cache_pdf.sh
--         if you want to clean the cache, please run clean_pdf.sh 
function typeset_demo_tasks()
    local errorlevel = 0
    local tutorialdir = typesetdir .. "/tutorial"
    local typesetcommand = typesetexe .. " " .. typesetopts   -- patch l3build
    print("============================================================")
    print("If you want to save the previous demo files")
    print("Please move the pdf into the support/tutorial directory.")
    print("============================================================")
    for _, p in ipairs(filelist(tutorialdir, "step*.tex")) do
        local pdffilename = string.gsub(p,".tex",".pdf")
        if fileexists(tutorialdir .. "/" .. pdffilename) == false then
            errorlevel = tex(p,tutorialdir,typesetcommand)
            if string.find(p,"+") ~= nil then
                if string.find(p,"-") ~= nil then
                    -- biber after compiling the first time if it is marked as "-"
                    errorlevel = biber(string.gsub(p,".tex",""),tutorialdir)
                end
                -- compile the second time if it is marked as "+"
                errorlevel = tex(p,tutorialdir,typesetcommand)
            end
            if errorlevel ~= 0 then
                print(pdffilename .. " compilation failed.")
                return errorlevel
            end
        else
            print(pdffilename .. " exists.")
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
    for _, p in ipairs(filelist(sourcefiledir, "*.dtx")) do
        local in_macro = nil
        local macro_body = ""
        local macro_desc = ""
        local in_code = false
        local captured = 0
        for line in io.lines(sourcefiledir .. "/" .. p) do
            if in_macro ~= nil and captured == 0 then
                -- Find TeX style definition, see Coding Style 2.1.2
                local def_param = string.match(line, "\\def" .. in_macro .. "([#%d]*)")
                -- Find LaTeX style definition, see Coding Style 2.1.3
                local comm_param, param_default = string.match(line, "\\[renew|provide|new]*%a+{" .. in_macro .. "}%[(%d)%]([%[%a*@*\\*%]]*)")
                if def_param ~= nil then
                    def_param = string.gsub(def_param, "#(%d)", "{$%1}")
                    macro_body = macro_body .. "\\" .. in_macro .. def_param
                    captured = 1
                elseif comm_param ~= nil then
                    comm_param = tonumber(comm_param)
                    if string.sub(in_macro,1,1) == "\\" then
                        macro_body = macro_body .. "\\" .. in_macro
                        captured = 2
                    else -- an environment
                        macro_body = macro_body .. "\\n\\\\begin{" .. in_macro .. "}"
                        captured = 3
                    end
                    if param_default ~= "" then
                        param_default = string.gsub(string.sub(param_default, 2, -2),"\\","\\\\") -- remove square brackets
                        macro_body = macro_body .. "[${1:" .. param_default .. "}]"
                    else
                        macro_body = macro_body .. "{$1}"
                    end
                    for i=2,comm_param do
                        macro_body = macro_body .. "{$" .. i  .."}"
                    end
                    if captured == 3 then
                        macro_body = macro_body .. "\\n\\t$" .. comm_param + 1 .. "\\n\\\\end{" .. in_macro .. "}\\n"
                    end
                -- Find begin macrocode environment, see Coding Style 2.3.2
                elseif line == "%    \\begin{macrocode}" then
                    in_code = true
                -- Won't find end macrocode environment, only capture the first part of this macro as description.
                elseif in_code == false then
                    -- Now it is just a plain description of this macro.
                    macro_desc = macro_desc ..
                    string.gsub(string.gsub(string.gsub(string.gsub(string.sub(line,2),"\\verb\"([^\"]+)\"","%1"),"\\","\\\\"),"\"","\\\""),"%s%s+","") .. "\\n"
                end
            end

            -- Find begin macro DocTeX environment, see Coding Style 2.3.1
            local env_beg = string.match(line, "\\begin{macro}{(\\*%a+)}")
            if env_beg ~= nil then
                in_macro = env_beg
            end
            -- Find end macro DocTeX environment, see Coding Style 2.3.1
            if string.match(line, "\\end{macro}") ~= nil and in_macro ~= nil then
                -- This macro is processed complete.
                local match_comm = string.gsub(in_macro, "\\", "\\\\")
                local scope = "doctex,tex"
                if captured >= 2 or macro_body == "" then
                    scope = scope .. ",latex"   -- public use
                end
                if macro_body == "" then
                    macro_body = match_comm     -- no abvious definition
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

function checkinit_hook()
    gen_snippets()

    -- Move generated files to the main directory when it starts to check.
    for _,file in pairs(installfiles) do
        return cp(file, unpackdir, "../")
    end
end