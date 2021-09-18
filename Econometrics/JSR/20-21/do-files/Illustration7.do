use "F:\3-Advanced Econometrics I\Practice\Data\Verbeek2008-ch7-credit.dta", clear

*1
describe

*2
summarize

*3.1
logit invgrade booklev ebit logsales reta wka

*3.2
ologit rating booklev ebit logsales reta wka

*4
summarize booklev ebit logsales reta wka

quietly logit invgrade booklev ebit logsales reta wka
scalar xblogit = _b[_cons] + _b[booklev]*0.2931868 + _b[ebit]*0.0938921 + _b[logsales]*7.995754 + _b[reta]*0.1569942 + _b[wka]*0.1404142
display exp(xblogit)/(1+exp(xblogit))

quietly ologit rating booklev ebit logsales reta wka
scalar xborden = _b[booklev]*0.2931868 + _b[ebit]*0.0938921 + _b[logsales]*7.995754 + _b[reta]*0.1569942+_b[wka]*0.1404142
display 1-exp(_b[/cut3]-xborden)/(1+exp(_b[/cut3]-xborden))

