use "F:\3-Advanced Econometrics I\Practice\Data\Greene2003-ch21-travelmode.dta", clear

*1
describe

*2.1
summarize Mode Ttme GC Hinc if Modealt=="air"
summarize Mode Ttme GC Hinc if Modealt=="bus"
summarize Mode Ttme GC Hinc if Modealt=="car"
summarize Mode Ttme GC Hinc if Modealt=="train"

*2.2
summarize Ttme GC Hinc if Modealt=="air" & Mode==1
summarize Ttme GC Hinc if Modealt=="train" & Mode==1
summarize Ttme GC Hinc if Modealt=="bus" & Mode==1
summarize Ttme GC Hinc if Modealt=="car" & Mode==1

*3.1
reshape wide Ttme GC Mode, i(id) j(Modealt) string
gen Y=0 if Modeair==1
replace Y=1 if Modetrain==1
replace Y=2 if Modebus==1
replace Y=3 if Modecar==1
mlogit Y Hinc, baseoutcome(0)

*3.2
reshape long
asclogit Mode Ttme GC, case(id) alternatives(Modealt) casevars(Hinc) basealternative(air)
