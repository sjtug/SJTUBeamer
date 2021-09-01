#!/usr/bin/env texlua

module           = "sjtubeamer"

sourcefiledir    = "source"
sourcefiles      = {"*.ins","*.dtx","*logo.pdf","sjtubadge.pdf","sjtubg.pdf","sjtubg.png","sjtuphoto.jpg"}
installfiles     = {"*.sty","*logo.pdf","sjtubadge.pdf","sjtubg.pdf","sjtubg.png","sjtuphoto.jpg"}

docfiledir       = "doc"

if os.type == "windows" then
    typesetexe       = "pdflatex"
else
    typesetexe       = "xelatex"
end

-- typesetfiles     = {"sjtubeamerdevguide.tex","sjtubeamer.tex"}
typesetfiles     = {"sjtubeamer.tex"}
typesetruns      = 1 -- for debug. Some reference may not be linked.
-- typesetdemofiles = {"min.tex"}
typesetsuppfiles = {"head.png","plant.jpg","test.csv","testgraph.tex","ref.bib","tutourial/"}

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

-- Generate tutourial files before compiling the doc.
-- NOTICE: if you want to save the tourial step pdf,
--         please enter support/tutourial adn run cache_pdf.sh
--         if you want to clean the cache, please run clean_pdf.sh 
function typeset_demo_tasks()
    local errorlevel = 0
    local tutourialdir = typesetdir .. "/tutourial"
    local typesetcommand = typesetexe .. " " .. typesetopts   -- patch l3build
    print("============================================================\n If you want to save the previous demo files\n Please move the pdf into the support/tutourial directory.\n============================================================")
    for _, p in ipairs(filelist(tutourialdir, "step*.tex")) do
        local pdffilename = string.gsub(p,".tex",".pdf")
        if fileexists(tutourialdir .. "/" .. pdffilename) == false then
            errorlevel = tex(p,tutourialdir,typesetcommand)
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

-- Move generated files to the main directory when it starts to check.
function checkinit_hook()
    for _,file in pairs(installfiles) do
        return cp(file, unpackdir, "../")
    end
end