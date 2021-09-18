use "F:\3-Advanced Econometrics I\Practice\Data\Verbeek2008-ch10-capitalstructure.dta", clear

xtset gvkey yeara

*1
xtdescribe
describe

*2
quietly regress mdr L.mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, vce(cluster gvkey)
estimates store POOLED

quietly xtreg mdr L.mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, vce(cluster gvkey)
estimates store RE

quietly xtreg mdr L.mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, fe vce(cluster gvkey)
estimates store FE

estimates table POOLED RE FE, b star

*3.1
xtivreg mdr (L.mdr=L2.mdr) ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, fd

*3.2
xtabond mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep vce(robust)

*3.3
xtabond mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep maxldep(2) vce(robust)

*3.4
xtdpdsys mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep vce(robust)

*4.1
quietly xtabond mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep vce(robust)
estat abond, artests(3)

*4.2
quietly xtabond mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep
estat sargan

*4.3
quietly xtabond mdr ebit_ta mb dep_ta lnta fa_ta rd_dum rd_ta indmedian rated, twostep vce(robust)
test L.mdr=1
