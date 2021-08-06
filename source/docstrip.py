with open("beamerthemeSJTUBeamermin.dtx","r",encoding="UTF-8") as f:
    rows = f.readlines()
    wf = open("beamerthemeSJTUBeamermin.sty","w",encoding="UTF-8")
    for row in rows:
        if not row[0]=="%":
            wf.write(row)
    wf.close()